import 'dart:io';

({String desc, String version, String? build})? getVersionAndBuildDetails(
  String workflowName,
  String filePath, {
  bool? returnSeparately = false,
}) {
  final versionBuild = _getVersionAndBuild(filePath);

  if (versionBuild == null) {
    return (
      desc: 'Version+Build Nr',
      version: 'Undetermined',
      build: null,
    );
  }

  final version = versionBuild.$1;
  final build = versionBuild.$2;

  if (returnSeparately ?? false) {
    return (
      desc: '',
      version: version,
      build: build,
    );
  }

  if (workflowName.toLowerCase().contains('ios') ||
      workflowName.toLowerCase().contains('distribution')) {
    return (
      desc: 'Version+Build Nr',
      version: '$version+$build',
      build: null,
    );
  } else if (workflowName.toLowerCase().contains('android')) {
    return (
      desc: 'Build Nr',
      version: build,
      build: null,
    );
  } else {
    return (
      desc: 'Version+Build Nr',
      version: 'Undetermined',
      build: null,
    );
  }
}

(String, String)? _getVersionAndBuild(String filePath) {
  try {
    var file = File('../$filePath/pubspec.yaml');
    if (!file.existsSync()) {
      print('pubspec.yaml file not found');
      return null;
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
