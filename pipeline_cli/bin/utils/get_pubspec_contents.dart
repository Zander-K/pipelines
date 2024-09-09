import 'dart:io';

String? getPubspecContents(String filePath) {
  try {
    var file = File(filePath);
    if (!file.existsSync()) {
      print('pubspec.yaml file not found');
      return null;
    }

    var contents = file.readAsStringSync();
    return contents;
  } catch (e) {
    print('Error reading pubspec.yaml file: $e');
    return '';
  }
}
