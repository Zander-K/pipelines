import 'dart:io';

(String, String) getVersionAndBuildDetails(
  String workflowName,
  String filePath,
) {
  final versionBuild = _getVersionAndBuild(filePath);

  final version = versionBuild.$1;
  final build = versionBuild.$2;

  if (workflowName.toLowerCase().contains('ios') ||
      workflowName.toLowerCase().contains('distribution')) {
    return ('Version+Build Nr', '$version+$build');
  } else if (workflowName.toLowerCase().contains('android')) {
    return ('Build Nr', build);
  } else {
    return ('Version+Build Nr', 'Undetermined');
  }
}

(String, String) _getVersionAndBuild(String filePath) {
  try {
    var file = File('$filePath/pubspec.yaml');
    if (!file.existsSync()) {
      print('pubspec.yaml file not found');
      return ('', '');
    }
    var contents = file.readAsStringSync();

    var versionRegex = RegExp(r'version:\s*([^\+]+)');
    var versionMatch = versionRegex.firstMatch(contents);
    var version =
        versionMatch != null ? versionMatch.group(1)?.trim() : 'Unknown';

    var buildRegex = RegExp(r'\+\s*(\d+)');
    var buildMatch = buildRegex.firstMatch(contents);
    var build = buildMatch != null ? buildMatch.group(1)?.trim() : 'Unknown';

    return (version ?? '', build ?? '');
  } catch (e) {
    print('Error in extract_pubspec_info and reading pubspec.yaml file: $e');
    return ('', '');
  }
}
