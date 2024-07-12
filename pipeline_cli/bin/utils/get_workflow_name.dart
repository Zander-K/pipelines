String getWorkflowName(String githubWorkflow) {
  var parts = githubWorkflow.split('/');
  return parts.length >= 3 ? parts[2] : 'Unknown Workflow';
}
