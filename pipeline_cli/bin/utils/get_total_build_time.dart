import 'dart:convert';
import 'dart:io';

import '../export.dart';

/// Returns a [String] with the total build time given a [workflowName].
///
/// For example, `10 minutes and 9 seconds`.
String getTotalBuildTime(String workflowName) {
  String totalBuildTimeFormatted = 'No build time';

  if (!workflowName.contains('Unknown')) {
    final totalBuildTimeInSeconds = _getBuildTimeInSeconds(workflowName) ?? 0;

    final totalBuildTime = Duration(seconds: totalBuildTimeInSeconds);

    totalBuildTimeFormatted =
        "${totalBuildTime.inMinutes} minutes and ${totalBuildTime.inSeconds % 60} seconds";
  }

  return totalBuildTimeFormatted;
}

/// Returns an [int]? of the total build time given [workflowName].
int? _getBuildTimeInSeconds(String workflowName) {
  try {
    final latestRunIdResult = Process.runSync('gh', [
      'run',
      'list',
      '--workflow',
      workflowName,
      '--limit',
      '1',
      '--json',
      'databaseId'
    ]);

    if (latestRunIdResult.exitCode != 0) {
      throw TotalBuildTimeException(latestRunIdResult.stderr);
    }

    final latestRunData = jsonDecode(latestRunIdResult.stdout);
    final latestRunId = latestRunData[0]['databaseId'].toString();

    final durationResult = Process.runSync(
        'gh', ['run', 'view', latestRunId, '--json', 'createdAt,updatedAt']);

    if (durationResult.exitCode != 0) {
      throw TotalBuildTimeException(durationResult.stderr);
    }

    final durationData = jsonDecode(durationResult.stdout);
    final startTime = durationData['createdAt'];
    final endTime = durationData['updatedAt'];

    final startTimeSec =
        DateTime.parse(startTime).toUtc().millisecondsSinceEpoch ~/ 1000;
    final endTimeSec =
        DateTime.parse(endTime).toUtc().millisecondsSinceEpoch ~/ 1000;

    return endTimeSec - startTimeSec;
  } on TotalBuildTimeException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  } catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  }
}
