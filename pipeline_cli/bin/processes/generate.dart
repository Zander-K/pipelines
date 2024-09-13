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

    final workflowType = getWorkflowType(workflowName);
    MessageContents? message;
    switch (workflowType) {
      case WorkflowType.qaGC:
        message = MessageContents.qaGrosDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      case WorkflowType.qaMB:
        message = MessageContents.qaMeccaDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      case WorkflowType.betaGC:
        message = MessageContents.betaGrosDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      case WorkflowType.betaMB:
        message = MessageContents.betaMeccaDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      case WorkflowType.prodGC:
        message = MessageContents.prodGrosDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      case WorkflowType.prodMB:
        message = MessageContents.prodMeccaDistribution(
          branch: branch,
          workflowName: workflowName,
        );
        break;
      default:
        message = MessageContents.defaultDistribution(
          branch: branch,
          workflowName: workflowName,
        );
    }

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
