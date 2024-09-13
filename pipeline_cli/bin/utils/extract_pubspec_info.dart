import 'dart:io';

/// Returns a [Record] with the label and version and/or build number given a
/// workflow name and directory path
///
/// An iOS workflow returns `Version+Build Nr` and `1.0.0+876`
/// An Android workflow returns `Build Nr` and `876`
///
/// Otherwise, `Version+Build Nr` and `Undetermined`
({String label, String versionOrBuild}) getVersionAndBuildDetails(
  String workflowName,
  String dirPath,
) {
  final versionBuild = _getVersionAndBuild(dirPath);

  final version = versionBuild.$1;
  final build = versionBuild.$2;

  if (workflowName.toLowerCase().contains('ios') ||
      workflowName.toLowerCase().contains('distribution')) {
    return (label: 'Version+Build Nr', versionOrBuild: '$version+$build');
  } else if (workflowName.toLowerCase().contains('android')) {
    return (label: 'Build Nr', versionOrBuild: build);
  } else {
    return (label: 'Version+Build Nr', versionOrBuild: 'Undetermined');
  }
}

(String, String) _getVersionAndBuild(String dirPath) {
  try {
    var file = File('$dirPath/pubspec.yaml');
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
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return ('', '');
  }
}
