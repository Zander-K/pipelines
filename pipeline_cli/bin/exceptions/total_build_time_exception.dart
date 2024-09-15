class TotalBuildTimeException implements Exception {
  final String message;

  TotalBuildTimeException(
      [this.message = 'Error fetching the last commit SHA.']);

  @override
  String toString() => 'TotalBuildTimeException: $message';
}
