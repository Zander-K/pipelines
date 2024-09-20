import 'dart:convert';
import 'dart:io';

import '../export.dart';

/// Returns a [String] of the workflow name given a [branch].
String? getWorkflowName(String branch) {
  try {
    String? workflow = Platform.environment['GITHUB_WORKFLOW'];

    if (workflow.isNullOrEmpty) {
      final result = Process.runSync(
        'gh',
        [
          'run',
          'list',
          '--json',
          'name',
          '--branch',
          branch,
          '--limit',
          '1',
        ],
        runInShell: true,
      );

      if (result.stderr.contains('gh')) {
        throw GhException(result.stderr);
      }

      if (result.exitCode != 0) {
        throw WorkflowNameException(result.stderr);
      }

      final workflowList = jsonDecode(result.stdout);

      if (workflowList.isEmpty) {
        throw WorkflowNameException('No workflow runs found.');
      }

      workflow = workflowList[0]['name'];
    }

    return workflow;
  } on WorkflowNameException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  } on GhException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    exit(1);
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
