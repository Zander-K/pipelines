import 'dart:io';

import '../utils/get_commit_hash.dart';
import '../utils/get_date_time.dart';
import '../utils/get_label.dart';
import '../utils/get_platform_type.dart';
import '../utils/get_platform_version.dart';
import '../utils/get_pubspec.dart';
import '../utils/get_total_build_time.dart';
import '../utils/get_version_build.dart';
import '../utils/get_workflow_name.dart';

void generate() {
  var githubWorkflow = 'owner/repository-name/workflow-name';
  var labels = ['Grosvenor', 'Label1', 'Label2'];
  var githubSha = 'abcdef1234567890';
  var buildStartTime = '2024-07-12T10:00:00Z';
  var buildEndTime = '2024-07-12T10:30:00Z';
  var pubspecPath = 'apps/grosvenor_prod/pubspec.yaml';
  var outputFile = File('output1.txt');

  var currentDateAndTime = getDateTime();
  print(currentDateAndTime);

  var workflowName = getWorkflowName(githubWorkflow);
  print('Workflow: $workflowName');

  var platformType = getPlatformType(workflowName);
  print(platformType);

  var labelName = getLabel(labels);
  print('Label: $labelName');

  var lastCommit = getLastCommitHash(githubSha);
  print('Last Commit: $lastCommit');

  var totalBuildTime = getTotalBuildTime(buildStartTime, buildEndTime);
  print('Total Build Time: $totalBuildTime seconds');

  var pubspecContents = readPubspecContents(pubspecPath);
  print('PUBSPEC_CONTENTS:');
  print(pubspecContents);

  var versionBuild = extractVersionBuild(pubspecPath);
  print('Version: ${versionBuild.$1}');
  print('Build: ${versionBuild.$2}');

  var formattedOutput =
      determinePlatformTypeAndFormatOutput(workflowName, versionBuild);
  print(formattedOutput);

  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }

  outputFile.writeAsStringSync('Output:\n');
  outputFile.writeAsStringSync('$currentDateAndTime\n', mode: FileMode.append);
  outputFile.writeAsStringSync('Platform: $platformType\n',
      mode: FileMode.append);
  outputFile.writeAsStringSync('$labelName\n', mode: FileMode.append);
  outputFile.writeAsStringSync('$lastCommit\n', mode: FileMode.append);
  outputFile.writeAsStringSync('$versionBuild\n', mode: FileMode.append);
  outputFile.writeAsStringSync('Total Build Time: $totalBuildTime seconds\n',
      mode: FileMode.append);
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
