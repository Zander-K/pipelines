class CommitHashException implements Exception {
  final String message;

  CommitHashException([this.message = 'Error fetching the last commit SHA.']);

  @override
  String toString() => 'CommitHashException: $message';
}
