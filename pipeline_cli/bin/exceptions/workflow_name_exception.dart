class WorkflowNameException implements Exception {
  final String message;

  WorkflowNameException([this.message = 'Error fetching the workflow name.']);

  @override
  String toString() => 'WorkflowNameException: $message';
}

class WorkflowRunIdException implements Exception {
  final String message;

  WorkflowRunIdException([this.message = 'Error fetching latest run ID.']);

  @override
  String toString() => 'WorkflowRunIdException: $message';
}
