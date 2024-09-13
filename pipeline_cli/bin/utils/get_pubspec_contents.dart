import 'dart:io';

/// Returns a [Record] with the Flutter version, Dart version, and contents
/// of installed packages given a directory path
({String flutter, String dart, String contents})? getPubspecInstalledPackages(
    String filePath) {
  try {
    var result = Process.runSync(
      'dart',
      ['pub', 'deps', '--style=list'],
      workingDirectory: './$filePath',
    );

    if (result.exitCode != 0) {
      print('Error running flutter pub deps: ${result.stderr}');
      return null;
    }

    var output = result.stdout as String;
    var lines = output.split('\n');

    String? flutterVersion;
    String? dartVersion;
    var dependencies = <String>[];
    var devDependencies = <String>[];
    var dependencyOverrides = <String>[];
    String? currentSection;

    for (var line in lines) {
      line = line.trimRight();

      if (line.contains('Flutter SDK')) {
        flutterVersion =
            RegExp(r'Flutter SDK\s+([\d\.]+)').firstMatch(line)?.group(1);
      }

      if (line.contains('Dart SDK')) {
        dartVersion =
            RegExp(r'Dart SDK\s+([\d\.]+)').firstMatch(line)?.group(1);
      }

      if (line.startsWith('dependencies:')) {
        currentSection = 'dependencies';
        continue;
      } else if (line.startsWith('dev dependencies:')) {
        currentSection = 'devDependencies';
        continue;
      } else if (line.startsWith('dependency overrides:')) {
        currentSection = 'dependencyOverrides';
        continue;
      } else if (line.startsWith('transitive dependencies:')) {
        currentSection = 'transitiveDependencies';
        continue;
      }

      if (currentSection == 'dependencies' ||
          currentSection == 'devDependencies' ||
          currentSection == 'dependencyOverrides') {
        if (line.startsWith('- ')) {
          var packageLine = line.substring(2).trim();

          if (currentSection == 'dependencies') {
            dependencies.add(packageLine);
          } else if (currentSection == 'devDependencies') {
            devDependencies.add(packageLine);
          } else if (currentSection == 'dependencyOverrides') {
            dependencyOverrides.add(packageLine);
          }
        }
      }
    }

    if (flutterVersion == null || dartVersion == null) {
      throw Exception(
          'Could not extract Flutter or Dart version from the output.');
    }

    final dependenciesOutput = _getDependenciesOutput(
      dependencies,
      devDependencies,
      dependencyOverrides,
    );

    return (
      flutter: flutterVersion,
      dart: dartVersion,
      contents: dependenciesOutput,
    );
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}

String _getDependenciesOutput(
  List<String> dependencies,
  List<String> devDependencies,
  List<String> dependencyOverrides,
) {
  StringBuffer outputBuffer = StringBuffer();

  if (dependencies.isNotEmpty) {
    outputBuffer.writeln('Dependencies:');
    for (var dep in dependencies) {
      outputBuffer.writeln('- $dep');
    }
    outputBuffer.writeln();
  }

  if (devDependencies.isNotEmpty) {
    outputBuffer.writeln('Dev Dependencies:');
    for (var devDep in devDependencies) {
      outputBuffer.writeln('- $devDep');
    }
    outputBuffer.writeln();
  }

  if (dependencyOverrides.isNotEmpty) {
    outputBuffer.writeln('Dependency Overrides:');
    for (var dep in dependencyOverrides) {
      outputBuffer.writeln('- $dep');
    }
    outputBuffer.writeln();
  }

  return outputBuffer.toString();
}
