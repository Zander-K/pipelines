import 'dart:convert';
import 'dart:io';

import '../exceptions/workflow_name_exception.dart';
import '../extensions/string.dart';

/// Returns a [String] of the workflow name
String? getWorkflowName(String branch) {
  try {
    String? workflow = Platform.environment['GITHUB_WORKFLOW'];

    if (workflow.isNullOrEmpty) {
      final workflowResult = Process.runSync('gh', [
        'run',
        'list',
        '--json',
        'name',
        '--branch',
        branch,
        '--limit',
        '35',
      ]);

      if (workflowResult.exitCode != 0) {
        throw WorkflowNameException(workflowResult.stderr);
      }

      final workflowList = jsonDecode(workflowResult.stdout);

      if (workflowList.isEmpty) {
        throw WorkflowNameException('No workflow runs found.');
      }

      workflow = workflowList[0]['name'];
    }

    // if (workflowName.toLowerCase().contains('production') ||
    //     workflowName.toLowerCase().contains('distribution')) {
    //   return workflowName;
    // }

    return workflow;
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
