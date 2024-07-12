import 'dart:io';

(String, String) extractVersionBuild(String filePath) {
  try {
    var file = File(filePath);
    var contents = file.readAsStringSync();

    // Extract version and build numbers
    var versionRegex = RegExp(r'version:\s*(\S+)');
    var match = versionRegex.firstMatch(contents);
    var version = match != null ? match.group(1) : 'Unknown';

    var buildRegex = RegExp(r'\+\s*(\d+)');
    match = buildRegex.firstMatch(contents);
    var build = match != null ? match.group(1) : 'Unknown';

    print('Version: $version');
    print('Build: $build');
    return (version ?? '', build ?? '');
  } catch (e) {
    print('Error reading pubspec.yaml file: $e');
    return ('', '');
  }
}
