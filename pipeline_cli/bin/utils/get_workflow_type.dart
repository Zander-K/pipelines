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

enum WorkflowType {
  qaGC('QA_GC'),
  betaGC('BETA_GC'),
  prodGC('PROD_GC'),
  qaMB('QA_MB'),
  betaMB('BETA_MB'),
  prodMB('PROD_MB');

  const WorkflowType(this.type);

  final String type;
}
