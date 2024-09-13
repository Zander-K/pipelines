/// Returns a [String] of the directory path to the pubspec.yaml file
///
/// For example, `apps/grosvenor_prod`.
String getPubspecPath(String workflowName) {
  final String folderName;

  if (workflowName.toLowerCase().contains('mb')) {
    folderName = 'meccabingo_prod';
  } else {
    folderName = 'grosvenor_prod';
  }

  return 'apps/$folderName';
}
