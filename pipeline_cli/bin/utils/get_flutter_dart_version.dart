import 'dart:io';

/// Returns a [String]? of the current Flutter version.
String? getFlutterVersion() {
  try {
    var flutterVersionOutput = _runCommand(['flutter', '--version']);
    var flutterVersion = RegExp(r'Flutter\s+([\d\.]+)')
        .firstMatch(flutterVersionOutput)
        ?.group(1);
    return flutterVersion;
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}

/// Returns a [String]? of the current Dart version.
String? getDartVersion() {
  try {
    var dartVersionOutput = _runCommand(['dart', '--version']);
    var dartVersion = RegExp(r'Dart\s+SDK\s+version:\s+([\d\.]+)')
        .firstMatch(dartVersionOutput)
        ?.group(1);
    return dartVersion;
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}

String _runCommand(List<String> command) {
  var result = Process.runSync(command[0], command.sublist(1));
  if (result.exitCode != 0) {
    throw Exception(
        'Error running command: ${command.join(' ')}\n${result.stderr}');
  }
  return result.stdout.trim();
}
