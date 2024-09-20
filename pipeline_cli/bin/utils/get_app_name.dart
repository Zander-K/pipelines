import 'dart:io';

import '../export.dart';

/// Returns a [String]? of the app name given a [dirPath] to the pubspec.yaml.
///
/// For example, `grosvenor_prod`.
String? getAppName(String workflowName) {
  try {
    final path = getPubspec(workflowName: workflowName);
    final file = File(path);

    final content = file.readAsStringSync();

    final regex = RegExp(r'^name:\s*(\S+)', multiLine: true);
    final match = regex.firstMatch(content);

    if (match == null) {
      throw PubspecException('App name not found in pubspec.yaml');
    }

    return match.group(1);
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
