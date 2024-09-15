import '../export.dart';

String createSDETTag({String? type, String? env, String? branch}) {
  final releaseType = type ?? 'RC';

  final workflowName = getWorkflowName(branch ?? 'develop') ?? '';
  final pubspecDir = getPubspecDirectory(workflowName);

  final environment = env ?? getEnvFromConfig(dirPath: pubspecDir);

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
