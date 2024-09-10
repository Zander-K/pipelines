import 'dart:io';

import '../export.dart';

Future<void> generate({
  required String? branch,
}) async {
  if (branch == null) {
    stdout.write(
        "No branch specified. Press Enter to use 'develop' or type a branch name: ");
    String? input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      branch = 'develop';
      print("Using 'develop' branch.\n");
    } else {
      branch = input;
      print("Using branch: $branch \n");
    }
  }

  var isValidBranch = checksBranch(branch);

  if (!isValidBranch) {
    return;
  }

  var workflowName = getWorkflowName() ?? '';
  var lastCommit = getLastCommitHash(branch);
  var currentDateAndTime = getDateTime();
  var platformType = getPlatformType(workflowName);
  var pubspecPath = getPubspecPath(workflowName);

  var totalBuildTimeFormatted = 'No build time';
  if (!workflowName.contains('Unknown')) {
    var totalBuildTimeInSeconds = getBuildTimeInSeconds(workflowName) ?? 0;
    var totalBuildTime = Duration(seconds: totalBuildTimeInSeconds);

    totalBuildTimeFormatted =
        "${totalBuildTime.inMinutes} minutes and ${totalBuildTime.inSeconds % 60} seconds";
  }

  var versionBuildDetails = getVersionAndBuildDetails(
    workflowName,
    pubspecPath,
  );
  var appName = getAppName(pubspecPath);
  var pubspecContents = getPubspecInstalledPackages(pubspecPath);

  var flutterVersion = pubspecContents?.flutter;
  var dartVersion = pubspecContents?.dart;

  var outputBuffer = StringBuffer();

  outputBuffer.writeln('-----------------------------------------------------');
  outputBuffer.writeln('** 📅\tCurrent Date: \t** ${currentDateAndTime.$1} **');
  outputBuffer
      .writeln('** ⏱️\tCurrent Time: \t** ${currentDateAndTime.$2} UTC **');
  outputBuffer.writeln('-----------------------------------------------------');
  outputBuffer.writeln('** 🛠️\tWorkflow Name: \t** $workflowName **');
  outputBuffer.writeln('** 📱\tPlatform: \t** $platformType **');
  outputBuffer.writeln('** 🏷️\tApp Name: \t** $appName **');
  outputBuffer.writeln('** 🔖\tCommit Hash: \t** $lastCommit **');
  outputBuffer.writeln('** 🔖\tBranch Name: \t** $branch **');
  outputBuffer
      .writeln('** ⏱️\tTotal Build Time: \t** $totalBuildTimeFormatted **');
  outputBuffer.writeln(
      '** 🔢\t${versionBuildDetails?.desc}: \t** ${versionBuildDetails?.version} **');
  outputBuffer.writeln('** 🦋\tFlutter Version: \t** $flutterVersion **');
  outputBuffer.writeln('** 🎯\tDart Version: \t\t** $dartVersion **\n');
  outputBuffer.writeln('-----------------------------------------------------');

  outputBuffer.writeln('** PUBSPEC.LOCK CONTENTS: Installed Packages **');
  outputBuffer
      .writeln('-----------------------------------------------------\n');
  outputBuffer.write(pubspecContents?.contents);
  outputBuffer.writeln('-----------------------------------------------------');

  print(outputBuffer.toString());
}
