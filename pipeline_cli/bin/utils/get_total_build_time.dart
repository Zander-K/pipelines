import 'dart:io';

Future<int?> getBuildTimeInSeconds(String workflowName) async {
  try {
    var latestRunIdResult = await Process.run('gh', [
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

    var latestRunId = latestRunIdResult.stdout
        .split('"databaseId": ')[1]
        .split(',')[0]
        .trim();

    var durationResult = await Process.run(
        'gh', ['run', 'view', latestRunId, '--json', 'createdAt,updatedAt']);

    if (durationResult.exitCode != 0) {
      print('Error fetching run details: ${durationResult.stderr}');
      return null;
    }

    var startTime =
        durationResult.stdout.split('"createdAt": "')[1].split('"')[0].trim();
    var endTime =
        durationResult.stdout.split('"updatedAt": "')[1].split('"')[0].trim();

    var startTimeSec =
        DateTime.parse(startTime).toUtc().millisecondsSinceEpoch ~/ 1000;
    var endTimeSec =
        DateTime.parse(endTime).toUtc().millisecondsSinceEpoch ~/ 1000;

    return endTimeSec - startTimeSec;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
