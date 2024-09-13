import '../export.dart';
import '../extensions/string.dart';
import '../utils/message_contents.dart';

void generate({
  required String? branch,
}) {
  try {
    if (branch.isNull) {
      branch = Prompts.branch();
    }

    final isBranchFound = checksBranch(branch!);
    if (!isBranchFound) {
      throw BranchNameException();
    }

    final workflowName = getWorkflowName(branch) ?? '';
    if (workflowName.isNullOrEmpty) {
      throw WorkflowNameException();
    }

    // Insert get_workflow_type here

    final message = MessageContents.qaDistribution(
      branch: branch,
      workflowName: workflowName,
    );

    print(message.getContents());
  } on BranchNameException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
  } on WorkflowNameException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
  } catch (e, s) {
    print('Unexpected error: $e');
    print('Stack Trace:');
    print('$s');
  }
}
