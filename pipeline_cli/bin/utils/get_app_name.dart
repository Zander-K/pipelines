import 'dart:io';

/// Returns a [String]? of the app name given a directory to the pubspec.yaml
///
/// For example, `grosvenor_prod`
String? getAppName(String filePath) {
  try {
    final file = File('$filePath/pubspec.yaml');
    if (!file.existsSync()) {
      print('pubspec.yaml file not found');
      return null;
    }

    final content = file.readAsStringSync();

    final regex = RegExp(r'^name:\s*(\S+)', multiLine: true);
    final match = regex.firstMatch(content);

    if (match != null) {
      return match.group(1);
    } else {
      print('App name not found in pubspec.yaml');
      return null;
    }
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
