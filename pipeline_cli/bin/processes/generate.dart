import 'dart:io';

import '../utils/get_commit_hash.dart';
import '../utils/get_date_time.dart';
import '../utils/get_flutter_dart_version.dart';
import '../utils/get_label.dart';
import '../utils/get_platform_type.dart';
import '../utils/get_total_build_time.dart';
import '../utils/extract_pubspec_info.dart';
import '../utils/get_workflow_name.dart';
import '../utils/get_pubspec_contents.dart';
import '../utils/get_pubspec_path.dart';

Future<void> generate({
  required String? labels,
}) async {
  //
  var outputFile = File('output1.txt');

  var workflowName = getWorkflowName() ?? '';
  var lastCommit = getLastCommitHash(labels ?? '');
  var currentDateAndTime = getDateTime();
  var platformType = getPlatformType(workflowName);
  var pubspecPath = getPubspecPath(workflowName);

  var totalBuildTimeInSeconds = getBuildTimeInSeconds(workflowName) ?? 0;
  var totalBuildTime = Duration(seconds: totalBuildTimeInSeconds);
  var totalBuildTimeFormatted =
      "${totalBuildTime.inMinutes} minutes and ${totalBuildTime.inSeconds % 60} seconds";

  var versionBuildDetails = getVersionAndBuildDetails(
    workflowName,
    pubspecPath,
  );
  var appName = getAppName(pubspecPath);
  var flutterVersion = getFlutterVersion();
  var dartVersion = getDartVersion();
  var pubspecContents = getPubspecContents(pubspecPath);

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
  outputBuffer
      .writeln('** ⏱️\tTotal Build Time: \t** $totalBuildTimeFormatted **');
  outputBuffer.writeln(
      '** 🔢\t${versionBuildDetails.$1}: \t\t** ${versionBuildDetails.$2} **');
  outputBuffer.writeln('** 🦋\tFlutter Version: \t** $flutterVersion **');
  outputBuffer.writeln('** 🎯\tDart Version: \t\t** $dartVersion **\n');
  outputBuffer.writeln('-----------------------------------------------------');

  outputBuffer.writeln('** PUBSPEC.YAML CONTENTS: **');
  outputBuffer
      .writeln('-----------------------------------------------------\n');
  outputBuffer.write(pubspecContents);
  outputBuffer.writeln('-----------------------------------------------------');

  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }

  outputFile.writeAsStringSync(outputBuffer.toString());

  print(outputBuffer.toString());
}
