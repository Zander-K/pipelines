String getTotalBuildTime(String buildStartTime, String buildEndTime) {
  int totalBuildTime;

  if (buildStartTime.isEmpty || buildEndTime.isEmpty) {
    totalBuildTime = 0;
  }

  // Parse ISO 8601 date strings to DateTime objects
  var startTime = DateTime.parse(buildStartTime);
  var endTime = DateTime.parse(buildEndTime);

  // Calculate the difference in seconds
  totalBuildTime = endTime.difference(startTime).inSeconds;

  return 'Total Build Time: $totalBuildTime seconds';
}
