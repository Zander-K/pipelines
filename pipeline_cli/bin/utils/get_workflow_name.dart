import 'dart:convert';
import 'dart:io';

/// Returns a [String] of the workflow name
String? getWorkflowName() {
  try {
    var workflowResult = Process.runSync(
        'gh', ['run', 'list', '--json', 'name', '--limit', '1']);

    if (workflowResult.exitCode != 0) {
      print('Error fetching the workflow name: ${workflowResult.stderr}');
      return null;
    }

    var workflowList = jsonDecode(workflowResult.stdout);

    if (workflowList.isNotEmpty) {
      final String workflowName = workflowList[0]['name'];

      if (workflowName.toLowerCase().contains('production') ||
          workflowName.toLowerCase().contains('distribution')) {
        return workflowName;
      }

      print('No distribution or production workflow run.');
      return 'Unknown';
    } else {
      print('No workflow runs found.');
      return null;
    }
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
