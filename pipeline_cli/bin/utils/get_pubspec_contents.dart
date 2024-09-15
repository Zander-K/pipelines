import 'dart:io';

import '../export.dart';

/// Returns a [Record] with the Flutter version, Dart version, and contents
/// of installed packages given a [dirPath].
({String flutter, String dart, String contents})? getPubspecInstalledPackages(
    String dirPath) {
  try {
    final path = getPubspecPath(
      dirPath: dirPath,
      onlyDirectory: true,
    );

    var result = Process.runSync(
      'dart',
      ['pub', 'deps', '--style=list'],
      workingDirectory: path,
    );

    if (result.exitCode != 0) {
      throw PubspecException(
          'Error running flutter pub deps: ${result.stderr}');
    }

    final output = result.stdout as String;
    final lines = output.split('\n');

    String? flutterVersion;
    String? dartVersion;
    final dependencies = <String>[];
    final devDependencies = <String>[];
    final dependencyOverrides = <String>[];
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
          final packageLine = line.substring(2).trim();

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
  } on PubspecException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
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
    for (final dep in dependencies) {
      outputBuffer.writeln('- $dep');
    }
    outputBuffer.writeln();
  }

  if (devDependencies.isNotEmpty) {
    outputBuffer.writeln('Dev Dependencies:');
    for (final devDep in devDependencies) {
      outputBuffer.writeln('- $devDep');
    }
    outputBuffer.writeln();
  }

  if (dependencyOverrides.isNotEmpty) {
    outputBuffer.writeln('Dependency Overrides:');
    for (final dep in dependencyOverrides) {
      outputBuffer.writeln('- $dep');
    }
    outputBuffer.writeln();
  }

  return outputBuffer.toString();
}
