import 'dart:io';
import 'dart:async';

Future<String> _runCommand(List<String> command) async {
  var result = await Process.run(command[0], command.sublist(1));
  if (result.exitCode != 0) {
    throw Exception(
        'Error running command: ${command.join(' ')}\n${result.stderr}');
  }
  return result.stdout.trim();
}

Future<String?> getFlutterVersion() async {
  try {
    var flutterVersionOutput = await _runCommand(['flutter', '--version']);
    var flutterVersion = RegExp(r'Flutter\s+([\d\.]+)')
        .firstMatch(flutterVersionOutput)
        ?.group(1);
    return flutterVersion;
  } catch (e) {
    print('Failed to get Flutter version: $e');
    return null;
  }
}

Future<String?> getDartVersion() async {
  try {
    var dartVersionOutput = await _runCommand(['dart', '--version']);
    var dartVersion = RegExp(r'Dart\s+SDK\s+version:\s+([\d\.]+)')
        .firstMatch(dartVersionOutput)
        ?.group(1);
    return dartVersion;
  } catch (e) {
    print('Failed to get Dart version: $e');
    return null;
  }
}

void main() async {
  var flutterVersion = await getFlutterVersion();
  var dartVersion = await getDartVersion();

  print('Flutter Version: $flutterVersion');
  print('Dart Version: $dartVersion');
}
