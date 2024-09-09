String getPlatformType(String workflowName) {
  final String platform;

  if (workflowName.toLowerCase().contains('ios')) {
    platform = 'iOS';
  } else if (workflowName.toLowerCase().contains('android')) {
    platform = 'Android';
  } else {
    if (workflowName.toLowerCase().contains('distribution')) {
      platform = 'Android / iOS';
    } else {
      platform = 'Unknown';
    }
  }

  return platform;
}
