import 'dart:convert';
import 'dart:io';

import '../exceptions/workflow_name_exception.dart';

/// Returns a [String] of the workflow name
String? getWorkflowName(String branch) {
  try {
    final workflowResult = Process.runSync('gh', [
      'run',
      'list',
      '--json',
      'name',
      '--branch',
      branch,
      '--limit',
      '1',
    ]);

    if (workflowResult.exitCode != 0) {
      throw WorkflowNameException(workflowResult.stderr);
    }

    final workflowList = jsonDecode(workflowResult.stdout);

    if (workflowList.isEmpty) {
      throw WorkflowNameException('No workflow runs found.');
    }

    final String workflowName = workflowList[0]['name'];

    // if (workflowName.toLowerCase().contains('production') ||
    //     workflowName.toLowerCase().contains('distribution')) {
    //   return workflowName;
    // }

    return workflowName;
  } on WorkflowNameException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
