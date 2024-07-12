int getTotalBuildTime(String buildStartTime, String buildEndTime) {
  if (buildStartTime.isEmpty || buildEndTime.isEmpty) {
    return 0; // Return 0 if start time or end time is empty
  }

  // Parse ISO 8601 date strings to DateTime objects
  var startTime = DateTime.parse(buildStartTime);
  var endTime = DateTime.parse(buildEndTime);

  // Calculate the difference in seconds
  var totalBuildTime = endTime.difference(startTime).inSeconds;

  return totalBuildTime;
}
