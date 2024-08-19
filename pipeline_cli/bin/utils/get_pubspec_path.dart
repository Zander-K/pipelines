String getPubspecPath(String workflowName) {
  final String folderName;

  if (workflowName.toLowerCase().contains('mb')) {
    folderName = 'meccabingo_prod';
  } else {
    folderName = 'grosvenor_prod';
  }

  return '../apps/$folderName/pubspec.yaml';
}
