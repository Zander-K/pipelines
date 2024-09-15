import 'dart:io';

import '../export.dart';

/// Returns a [Record] with the label and version and/or build number given a
/// [workflowName] and [dirPath].
///
/// If [returnSeparately] is true, it will return the version and build numbers
/// separately.
///
/// An iOS workflow returns `Version+Build Nr` and `1.0.0+876`
/// An Android workflow returns `Build Nr` and `876`
///
/// Otherwise, `Version+Build Nr` and `Undetermined`
VersionBuildDetails getVersionAndBuildDetails(
  String workflowName,
  String dirPath, {
  bool? returnSeparately = false,
}) {
  final versionBuild = _getVersionAndBuild(dirPath);

  if (versionBuild == null) {
    return VersionBuildDetails(
      label: 'Version+Build Nr',
      versionOrBuild: 'Undetermined',
      build: null,
    );
  }

  final version = versionBuild.$1 ?? '';
  final build = versionBuild.$2 ?? '';

  if (returnSeparately ?? false) {
    return VersionBuildDetails(
      label: '',
      versionOrBuild: version,
      build: build,
    );
  }

  if (workflowName.toLowerCase().contains('ios') ||
      workflowName.toLowerCase().contains('distribution')) {
    return VersionBuildDetails(
      label: 'Version+Build Nr',
      versionOrBuild: '$version+$build',
      build: null,
    );
  } else if (workflowName.toLowerCase().contains('android')) {
    return VersionBuildDetails(
      label: 'Build Nr',
      versionOrBuild: build,
      build: null,
    );
  } else {
    return VersionBuildDetails(
      label: 'Version+Build Nr',
      versionOrBuild: 'Undetermined',
      build: null,
    );
  }
}

(String?, String?)? _getVersionAndBuild(String dirPath) {
  try {
    final path = getPubspecPath(dirPath: dirPath);
    final file = File(path);

    final contents = file.readAsStringSync();

    final versionRegex = RegExp(r'version:\s*([^\+]+)');
    final versionMatch = versionRegex.firstMatch(contents);
    final version =
        versionMatch != null ? versionMatch.group(1)?.trim() : 'Unknown';

    final buildRegex = RegExp(r'\+\s*(\d+)');
    final buildMatch = buildRegex.firstMatch(contents);
    final build = buildMatch != null ? buildMatch.group(1)?.trim() : 'Unknown';

    return (version, build);
  } on PubspecException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  } catch (e, s) {
    print('Unexpected error: $e');
    print('Stack Trace:');
    print('$s');
    return null;
  }
}

class VersionBuildDetails {
  VersionBuildDetails({
    required this.label,
    required this.versionOrBuild,
    required this.build,
  });

  final String label;
  final String versionOrBuild;
  final String? build;
}
