import '../export.dart';

String createSDETTag({String? type, String? env}) {
  final releaseType = type ?? 'RC';

  var workflowName = getWorkflowName() ?? '';
  var pubspecPath = getPubspecPath(workflowName);

  final environment = env ?? getEnvFromConfig(pubspecPath);

  var versionBuildDetails = getVersionAndBuildDetails(
    workflowName,
    pubspecPath,
    returnSeparately: true,
  );

  if (versionBuildDetails?.build == null) {
    print('Error. No build number.');
    return '';
  }

  var appVersion = versionBuildDetails?.version;
  var buildNumber = versionBuildDetails?.build;

  var buildTag = '';
  if (releaseType == 'RC') {
    buildTag = '${appVersion}_$buildNumber.$releaseType.$environment';
  } else {
    buildTag = '${appVersion}_$buildNumber.$releaseType.$environment';
  }

  return buildTag;
}
