String getWorkflowName(String githubWorkflow) {
  var parts = githubWorkflow.split('/');
  final name = parts.length >= 3 ? parts[2] : 'Unknown Workflow';
  return 'Workflow: $name';
}
