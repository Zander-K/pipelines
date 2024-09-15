import 'dart:io';

/// Returns a [String]? of config file path given a [directoryPath].
String? searchConfigFile(String directoryPath) {
  final configFilePattern = RegExp(r'^.*_config\.json$');

  final directory = Directory(directoryPath);

  if (!directory.existsSync()) {
    print('Directory not found: $directoryPath');
    return null;
  }

  try {
    final List<FileSystemEntity> files = directory.listSync();

    for (var file in files) {
      if (file is File) {
        if (configFilePattern.hasMatch(file.uri.pathSegments.last)) {
          return file.path;
        }

        /// In case there are multiple file, return the first one.

        return file.path;
      }
    }
  } catch (e) {
    print('Error while searching for config file: $e');
    return null;
  }

  print('No config file found in the directory.');
  return null;
}
