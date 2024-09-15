import '../export.dart';

/// Returns a [WorkflowType] given a [workflowName]
///
/// For example, `WorkflowType.qaGC` or `WorkflowType.prodMB`å
WorkflowType? getWorkflowType(String workflowName) {
  final workflow = workflowName.toLowerCase();

  if (workflow.contains('qa')) {
    if (workflow.contains('mb')) {
      return WorkflowType.qaMB;
    }
    return WorkflowType.qaGC;
  }

  if (workflow.contains('beta')) {
    if (workflow.contains('mb')) {
      return WorkflowType.betaMB;
    }
    return WorkflowType.betaGC;
  }

  if (workflow.contains('production')) {
    if (workflow.contains('mb')) {
      return WorkflowType.prodMB;
    }
    return WorkflowType.prodGC;
  }
  return null;
}
