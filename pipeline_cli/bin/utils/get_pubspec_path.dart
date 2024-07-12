String? getPubspecPath(String label) {
  final String folderName;

  if (label.toLowerCase().contains('grosvenor')) {
    folderName = 'grosvenor_prod';
  } else if (label.toLowerCase().contains('mecca')) {
    folderName = 'mecca_prod';
  } else {
    folderName = 'blank';
  }

  return 'apps/$folderName/pubspec.yaml';
}
