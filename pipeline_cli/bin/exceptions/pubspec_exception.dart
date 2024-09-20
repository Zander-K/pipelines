class PubspecException implements Exception {
  final String message;

  PubspecException([this.message = 'pubspec.yaml file not found']);

  @override
  String toString() => 'PubspecException: $message';
}
