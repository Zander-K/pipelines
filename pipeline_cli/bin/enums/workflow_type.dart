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
