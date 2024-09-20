import 'dart:io';

import '../export.dart';

/// Returns a [String] of the path to the pubspec.yaml file based on the [Platform]
/// or only the directory depending on [onlyDirectory] value given the [dirPath].
///
/// For example, `./apps/grosvenor_prod/pubspec.yaml` in case the platform in a
/// terminal.
///
/// Or `./apps/grosvenor_prod/` in case [onlyDirectory] is true.
String getPubspec({
  required String workflowName,
  bool? onlyDirectory = false,
}) {
  try {
    const pubspec = 'pubspec.yaml';
    String path;

    final dirPath = _getPubspecDirectory(workflowName);

    if (Platform.environment.containsKey('GITHUB_WORKFLOW')) {
      if (onlyDirectory ?? false) {
        path = './$dirPath/';
      } else {
        path = './$dirPath/$pubspec';
      }
    } else if (Platform.environment.containsKey('VSCODE_CWD') ||
        Platform.environment.containsKey('ANDROID_HOME')) {
      if (onlyDirectory ?? false) {
        path = '../$dirPath/';
      } else {
        path = '../$dirPath/$pubspec';
      }
    } else {
      if (onlyDirectory ?? false) {
        path = './$dirPath/';
      } else {
        path = './$dirPath/$pubspec';
      }
    }

    if (onlyDirectory ?? false) {
      return path;
    }

    final file = File(path);
    if (!file.existsSync()) {
      throw PubspecException();
    }

    return path;
  } on PubspecException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
  }
  return '';
}

String _getPubspecDirectory(String workflowName) {
  final String appFolderName;

  if (workflowName.toLowerCase().contains('mb')) {
    appFolderName = 'meccabingo_prod';
  } else {
    appFolderName = 'grosvenor_prod';
  }

  return 'apps/$appFolderName';
}
