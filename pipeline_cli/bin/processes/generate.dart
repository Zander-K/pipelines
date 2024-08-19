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
  required String? workflow,
  required String? labels,
  required String? commit,
}) async {
  //
  // List<String> prLabels = [labels ?? 'Grosvenor', 'Label1', 'Label2'];
  // var labelName = getLabel(prLabels);
  var outputFile = File('output1.txt');

  var workflowName = getWorkflowName() ?? '';
  var lastCommit = await getLastCommitHash();
  var currentDateAndTime = getDateTime();
  var platformType = getPlatformType(workflowName);
  var pubspecPath = getPubspecPath(workflowName);

  var totalBuildTimeInSeconds = await getBuildTimeInSeconds(workflowName) ?? 0;
  var totalBuildTime = Duration(seconds: totalBuildTimeInSeconds);
  var totalBuildTimeFormatted =
      "${totalBuildTime.inMinutes} minutes and ${totalBuildTime.inSeconds % 60} seconds";

  var versionBuild = await getVersionBuild(pubspecPath);
  var appName = await getAppName(pubspecPath);
  var flutterVersion = getFlutterVersion();
  var dartVersion = getDartVersion();
  var pubspecContents = getPubspecContents(pubspecPath);

  // Map<String, String> dependencies = extractDependencies(pubspecContents);
  // Map<String, String> devDependencies = extractDevDependencies(pubspecContents);

  var outputBuffer = StringBuffer();

  outputBuffer.writeln('-----------------------------------------------------');
  outputBuffer.writeln('** 📅\tCurrent Date: ** ${currentDateAndTime.$1} **');
  outputBuffer
      .writeln('** ⏱️\tCurrent Time: ** ${currentDateAndTime.$2} UTC **');
  outputBuffer.writeln('-----------------------------------------------------');
  outputBuffer.writeln('** 🛠️\tWorkflow Name: ** $workflowName **');
  outputBuffer.writeln('** 📱\tPlatform: ** $platformType **');
  outputBuffer.writeln('** 🏷️\tApp Name: ** $appName **');
  outputBuffer.writeln('** 🔖\tCommit Hash: ** $lastCommit **');
  outputBuffer
      .writeln('** ⏱️\tTotal Build Time: ** $totalBuildTimeFormatted **');
  outputBuffer.writeln('** 🔢\tBuild Number: ** ${versionBuild.$2} **');
  outputBuffer.writeln('** \tFlutter Version: ** $flutterVersion **');
  outputBuffer.writeln('** \tDart Version: ** $dartVersion **');
  outputBuffer
      .writeln('-----------------------------------------------------\n');

  outputBuffer.writeln('### **Pubspec.yaml Contents:**');
  outputBuffer.write(pubspecContents);
  outputBuffer.writeln('---\n');

  if (outputFile.existsSync()) {
    outputFile.deleteSync();
  }

  outputFile.writeAsStringSync(outputBuffer.toString());

  print(outputBuffer.toString());
}

Map<String, String> extractDependencies(String pubspecContents) {
  var dependencies = <String, String>{};
  var inDependenciesSection = false;

  pubspecContents.split('\n').forEach((line) {
    line = line.trim();
    if (line.startsWith('dependencies:')) {
      inDependenciesSection = true;
    } else if (inDependenciesSection &&
        line.isNotEmpty &&
        !line.startsWith('dev_dependencies:')) {
      var parts = line.split(':');
      if (parts.length == 2) {
        dependencies[parts[0].trim()] = parts[1].trim();
      }
    } else if (line.startsWith('dev_dependencies:')) {
      inDependenciesSection = false;
    }
  });

  return dependencies;
}

Map<String, String> extractDevDependencies(String pubspecContents) {
  var devDependencies = <String, String>{};
  var inDevDependenciesSection = false;

  pubspecContents.split('\n').forEach((line) {
    line = line.trim();
    if (line.startsWith('dev_dependencies:')) {
      inDevDependenciesSection = true;
    } else if (inDevDependenciesSection && line.isNotEmpty) {
      var parts = line.split(':');
      if (parts.length == 2) {
        devDependencies[parts[0].trim()] = parts[1].trim();
      }
    }
  });

  return devDependencies;
}

String determinePlatformTypeAndFormatOutput(
    String workflowName, (String, String) versionBuild) {
  String version = versionBuild.$1;
  String buildNumber = versionBuild.$2;

  String platformType;
  if (workflowName.contains('android')) {
    platformType = 'Android';
  } else if (workflowName.contains('ios')) {
    platformType = 'iOS';
  } else {
    platformType = 'Unknown Platform';
  }

  return 'Platform: $platformType\nVersion: $version\nBuild Number: $buildNumber';
}
