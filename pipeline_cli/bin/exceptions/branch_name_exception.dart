class BranchNameException implements Exception {
  final String message;

  BranchNameException(
      [this.message = 'Branch is either not found or not valid']);

  @override
  String toString() => 'BranchNotFoundException: $message';
}
