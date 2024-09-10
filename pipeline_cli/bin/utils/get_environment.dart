import 'dart:convert';
import 'dart:io';

import '../extensions/string.dart';

String? getEnvFromConfig(String filePath) {
  try {
    final file = File(filePath);
    if (!file.existsSync()) {
      print('Config file not found.');
      return null;
    }

    final jsonString = file.readAsStringSync();
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    if (jsonData.containsKey('config_name')) {
      final String configName = jsonData['config_name'] ?? '';

      if (configName.contains('dev')) {
        return 'Development';
      } else if (configName.contains('staging') || configName.contains('stg')) {
        return 'Staging';
      }

      return configName.capitalized ?? 'Production';
    } else {
      return 'Production';
    }
  } catch (e) {
    print('Error reading or parsing the file: $e');
    return null;
  }
}
