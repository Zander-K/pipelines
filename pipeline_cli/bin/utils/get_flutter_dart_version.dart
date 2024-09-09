import 'dart:io';

String _runCommand(List<String> command) {
  var result = Process.runSync(command[0], command.sublist(1));
  if (result.exitCode != 0) {
    throw Exception(
        'Error running command: ${command.join(' ')}\n${result.stderr}');
  }
  return result.stdout.trim();
}

String? getFlutterVersion() {
  try {
    var flutterVersionOutput = _runCommand(['flutter', '--version']);
    var flutterVersion = RegExp(r'Flutter\s+([\d\.]+)')
        .firstMatch(flutterVersionOutput)
        ?.group(1);
    return flutterVersion;
  } catch (e) {
    print('Failed to get Flutter version: $e');
    return null;
  }
}

String? getDartVersion() {
  try {
    var dartVersionOutput = _runCommand(['dart', '--version']);
    var dartVersion = RegExp(r'Dart\s+SDK\s+version:\s+([\d\.]+)')
        .firstMatch(dartVersionOutput)
        ?.group(1);
    return dartVersion;
  } catch (e) {
    print('Failed to get Dart version: $e');
    return null;
  }
}
