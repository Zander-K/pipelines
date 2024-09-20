class GhException implements Exception {
  final String message;

  GhException([this.message = 'gh cli issue']);

  @override
  String toString() => 'GhException: $message';
}
