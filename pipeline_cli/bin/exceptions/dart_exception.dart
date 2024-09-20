class DartException implements Exception {
  final String message;

  DartException([this.message = 'Dart exception']);

  @override
  String toString() => 'DartException: $message';
}
