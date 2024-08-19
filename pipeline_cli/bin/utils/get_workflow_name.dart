import 'dart:convert';
import 'dart:io';

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
      return workflowList[0]['name'];
    } else {
      print('No workflow runs found.');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

void main() async {
  var workflowName = getWorkflowName();

  if (workflowName != null) {
    print('Workflow Name: $workflowName');
  } else {
    print('Failed to retrieve the workflow name.');
  }
}
