String determinePlatformTypeAndFormatOutput(
    String workflowName, (String, String) versionBuild) {
  if (workflowName.contains('ios')) {
    return 'Version Nr: ${versionBuild.$1}\nBuild Nr: ${versionBuild.$2}\n';
  } else if (workflowName.contains('android')) {
    return 'Build Nr: ${versionBuild.$2}\n';
  } else {
    return 'Platform not recognized.\nVersion Nr: -\nBuild Nr: -\n';
  }
}
