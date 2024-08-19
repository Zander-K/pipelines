import 'dart:io';

String getLabel(List<String> labels) {
  final String label;

  if (labels.contains('Grosvenor') || labels.contains('grosvenor')) {
    label = 'Grosvenor';
  } else if (labels.contains('Mecca') || labels.contains('mecca')) {
    label = 'Mecca';
  } else {
    label = 'Unknown';
  }

  return 'Label: $label';
}

Future<String?> getAppName(String filePath) async {
  try {
    final file = File(filePath);
    if (!await file.exists()) {
      print('pubspec.yaml file not found');
      return null;
    }

    final content = await file.readAsString();

    final regex = RegExp(r'^name:\s*(\S+)', multiLine: true);
    final match = regex.firstMatch(content);

    if (match != null) {
      return match.group(1);
    } else {
      print('App name not found in pubspec.yaml');
      return null;
    }
  } catch (e) {
    print('Error reading pubspec.yaml: $e');
    return null;
  }
}

void main() async {
  var appName = await getAppName('apps/grosvenor_prod/pubspec.yaml');

  if (appName != null) {
    print('App Name: $appName');
  } else {
    print('Failed to retrieve the app name.');
  }
}
