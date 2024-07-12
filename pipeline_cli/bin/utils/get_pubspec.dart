import 'dart:io';

String readPubspecContents(String filePath) {
  try {
    var file = File(filePath);
    var contents = file.readAsStringSync();
    return contents;
  } catch (e) {
    print('Error reading pubspec.yaml file: $e');
    return '';
  }
}
