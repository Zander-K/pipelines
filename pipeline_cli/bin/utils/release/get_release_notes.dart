import 'dart:io';

/// Returns a [String] with either the contents of the release notes if the
/// [value] is a path or only the value.
String getReleaseNotes(String value) {
  String path = value;

  if (Platform.environment.containsKey('VSCODE_CWD')) {
    if (value.startsWith('./')) {
      path = '.$value';
    }
  }
  final file = File(path);

  if (file.existsSync()) {
    return file.readAsStringSync();
  } else {
    return value;
  }
}
