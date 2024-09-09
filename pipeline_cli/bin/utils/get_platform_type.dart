String getPlatformType(String workflowName) {
  final String platform;

  if (workflowName.toLowerCase().contains('ios')) {
    platform = 'iOS';
  } else if (workflowName.toLowerCase().contains('android')) {
    platform = 'Android';
  } else {
    platform = 'Unknown';
  }

  return platform;
}
