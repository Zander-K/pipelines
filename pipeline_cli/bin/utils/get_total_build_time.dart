String getTotalBuildTime(String buildStartTime, String buildEndTime) {
  int totalBuildTime;

  if (buildStartTime.isEmpty || buildEndTime.isEmpty) {
    totalBuildTime = 0;
  }

  var startTime = DateTime.parse(buildStartTime);
  var endTime = DateTime.parse(buildEndTime);

  totalBuildTime = endTime.difference(startTime).inSeconds;

  return 'Total Build Time: $totalBuildTime seconds';
}
