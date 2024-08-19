import 'dart:io';

Future<(String, String)> getVersionBuild(String filePath) async {
  try {
    var file = File(filePath);
    if (!await file.exists()) {
      print('pubspec.yaml file not found');
      return ('', '');
    }
    var contents = file.readAsStringSync();

    var versionRegex = RegExp(r'version:\s*([^\+]+)');
    var versionMatch = versionRegex.firstMatch(contents);
    var version =
        versionMatch != null ? versionMatch.group(1)?.trim() : 'Unknown';

    var buildRegex = RegExp(r'\+\s*(\d+)');
    var buildMatch = buildRegex.firstMatch(contents);
    var build = buildMatch != null ? buildMatch.group(1)?.trim() : 'Unknown';

    return (version ?? '', build ?? '');
  } catch (e) {
    print('Error reading pubspec.yaml file: $e');
    return ('', '');
  }
}
