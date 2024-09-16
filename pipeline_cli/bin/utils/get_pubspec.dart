import 'dart:io';

import '../export.dart';

/// Returns a [String] of the directory path to the pubspec.yaml file from a given
/// [workflowName].
///
/// For example, `apps/grosvenor_prod`.
String getPubspecDirectory(String workflowName) {
  final String folderName;

  if (workflowName.toLowerCase().contains('mb')) {
    folderName = 'meccabingo_prod';
  } else {
    folderName = 'grosvenor_prod';
  }

  return 'apps/$folderName';
}

/// Returns a [String] of the path to the pubspec.yaml file based on the [Platform]
/// or only the directory depending on [onlyDirectory] value given the [dirPath].
///
/// For example, `./apps/grosvenor_prod/pubspec.yaml` in case the platform in a
/// terminal.
///
/// Or `./apps/grosvenor_prod/` in case [onlyDirectory] is true.
String getPubspecPath({
  required String dirPath,
  bool? onlyDirectory = false,
}) {
  try {
    String path;

    if (Platform.environment.containsKey('GITHUB_WORKFLOW')) {
      if (onlyDirectory ?? false) {
        path = './$dirPath/';
      } else {
        path = './$dirPath/pubspec.yaml';
      }
    } else if (Platform.environment.containsKey('VSCODE_CWD') ||
        Platform.environment.containsKey('ANDROID_HOME')) {
      if (onlyDirectory ?? false) {
        path = '../$dirPath/';
      } else {
        path = '../$dirPath/pubspec.yaml';
      }
    } else {
      if (onlyDirectory ?? false) {
        path = './$dirPath/';
      } else {
        path = './$dirPath/pubspec.yaml';
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
