class BranchNotFoundException implements Exception {
  final String message;

  BranchNotFoundException(
      [this.message = 'Branch is either not found or not valid']);

  @override
  String toString() => 'BranchNotFoundException: $message';
}
