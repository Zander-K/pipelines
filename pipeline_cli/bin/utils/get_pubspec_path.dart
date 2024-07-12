String? getPubspecPath(String label) {
  final String folderName;

  if (label.toLowerCase().contains('grosvenor')) {
    folderName = 'grosvenor_prod';
  } else if (label.toLowerCase().contains('mecca')) {
    folderName = 'meccabingo_prod';
  } else {
    folderName = 'grosvenor_prod';
  }

  return 'apps/$folderName/pubspec.yaml';
}
