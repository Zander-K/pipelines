import 'dart:convert';
import 'dart:io';

/// Returns an [int]? of the total build time given workflow name
int? getBuildTimeInSeconds(String workflowName) {
  try {
    var latestRunIdResult = Process.runSync('gh', [
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
      print('Error fetching latest run ID: ${latestRunIdResult.stderr}');
      return null;
    }

    var latestRunData = jsonDecode(latestRunIdResult.stdout);
    var latestRunId = latestRunData[0]['databaseId'].toString();

    var durationResult = Process.runSync(
        'gh', ['run', 'view', latestRunId, '--json', 'createdAt,updatedAt']);

    if (durationResult.exitCode != 0) {
      print('Error fetching run details: ${durationResult.stderr}');
      return null;
    }

    var durationData = jsonDecode(durationResult.stdout);
    var startTime = durationData['createdAt'];
    var endTime = durationData['updatedAt'];

    var startTimeSec =
        DateTime.parse(startTime).toUtc().millisecondsSinceEpoch ~/ 1000;
    var endTimeSec =
        DateTime.parse(endTime).toUtc().millisecondsSinceEpoch ~/ 1000;

    return endTimeSec - startTimeSec;
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
