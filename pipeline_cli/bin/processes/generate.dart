import 'dart:io';

import '../utils/get_commit_hash.dart';
import '../utils/get_date_time.dart';
import '../utils/get_label.dart';
import '../utils/get_platform_type.dart';
import '../utils/get_platform_version.dart';
import '../utils/get_pubspec.dart';
import '../utils/get_pubspec_path.dart';
import '../utils/get_total_build_time.dart';
import '../utils/get_version_build.dart';
import '../utils/get_workflow_name.dart';

void generate(List<String?> values) {
  var githubWorkflow = values[0] ?? 'Build-android';
  List<String> labels = [values[1] ?? 'Grosvenor', 'Label1', 'Label2'];
  var githubSha = values[2] ?? 'abcdef1234567890';
  var buildStartTime = '2024-07-12T10:00:00Z';
  var buildEndTime = '2024-07-12T10:30:00Z';
  // var pubspecPath = 'apps/grosvenor_prod/pubspec.yaml';
  var outputFile = File('output1.txt');

  var currentDateAndTime = getDateTime();
  print(currentDateAndTime);

  var workflowName = getWorkflowName(githubWorkflow);
  print('Workflow Name: $workflowName');

  var platformType = getPlatformType(workflowName);
  print(platformType);

  var labelName = getLabel(labels);
  print(labelName);

  var lastCommit = getLastCommitHash(githubSha);
  print(lastCommit);

  var totalBuildTime = getTotalBuildTime(buildStartTime, buildEndTime);
  print(totalBuildTime);

  var pubspecPath =
      getPubspecPath(labelName) ?? 'apps/grosvenor_prod/pubspec.yaml';

  var versionBuild = extractVersionBuild(pubspecPath);
  print('Version+Build Nr: ${versionBuild.$1}+${versionBuild.$2}');

  var formattedOutput =
      determinePlatformTypeAndFormatOutput(workflowName, versionBuild);
  print(formattedOutput);

  var pubspecContents = readPubspecContents(pubspecPath);
  print('------------------------------\n');
  print('Pubspec.yaml Information:\n');
  print('------------------------------\n');
  print(pubspecContents);
  print('------------------------------\n');

  if (Platform.environment['GITHUB_ACTIONS'] != 'true') {
    if (outputFile.existsSync()) {
      outputFile.deleteSync();
    }

    // outputFile.writeAsStringSync('Output:\n');
    outputFile.writeAsStringSync('$currentDateAndTime\n',
        mode: FileMode.append);
    outputFile.writeAsStringSync('$workflowName\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$platformType\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$labelName\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$lastCommit\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$totalBuildTime\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$versionBuild\n', mode: FileMode.append);
    outputFile.writeAsStringSync('$formattedOutput\n', mode: FileMode.append);
    outputFile.writeAsStringSync('------------------------------\n',
        mode: FileMode.append);
    outputFile.writeAsStringSync('Pubspec.yaml Information:\n',
        mode: FileMode.append);
    outputFile.writeAsStringSync('------------------------------\n',
        mode: FileMode.append);
    outputFile.writeAsStringSync('$pubspecContents\n', mode: FileMode.append);
    outputFile.writeAsStringSync('------------------------------\n',
        mode: FileMode.append);
  }
}
