import 'dart:io';

/// Returns a [String] with either the contents of the release notes if the
/// [value] is a path or only the value.
String getReleaseNotes(String value) {
  final file = File(value);

  if (file.existsSync()) {
    return file.readAsStringSync();
  } else {
    return value;
  }
}
