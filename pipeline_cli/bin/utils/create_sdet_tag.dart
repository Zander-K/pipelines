import '../export.dart';

/// Returns a [String] with a tag given the [type], [env], and [branch].
/// It looks at the pubspec.yaml file to determine the version and build numbers.
///
/// For example, `1.1.0_876.[type].[env].
String createSDETTag({
  String? type,
  String? env,
  String? branch,
}) {
  final releaseType = type ?? 'RC';
  String? environment = env;

  final workflowName = getWorkflowName(branch ?? 'develop') ?? '';
  final pubspecDir = getPubspecDirectory(workflowName);
  final pubspec = getPubspecPath(dirPath: pubspecDir, onlyDirectory: true);

  if (env.isNullOrEmpty) {
    environment = getEnvFromConfig(dirPath: pubspec);
  }

  final versionBuildDetails = getVersionAndBuildDetails(
    workflowName,
    pubspecDir,
    returnSeparately: true,
  );

  if (versionBuildDetails.build == null) {
    print('Error. No build number.');
    return '';
  }

  final appVersion = versionBuildDetails.versionOrBuild;
  final buildNumber = versionBuildDetails.build;

  final buildTag = '${appVersion}_$buildNumber.$releaseType.$environment';

  return buildTag;
}
