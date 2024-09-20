import 'dart:convert';
import 'dart:io';

import '../extensions/string.dart';
import 'get_config_file.dart';

/// Returns a [String]? with the environment give a [filePath] to the config file.
///
/// For example, `Development` or `Production` if no config file is found.
String? getEnvFromConfig({required String dirPath}) {
  try {
    final configFilePath = searchConfigFile(dirPath) ?? '';

    final file = File(configFilePath);
    if (!file.existsSync()) {
      print('Config file not found. Defaulting to Staging');
      return 'Staging';
    }

    final jsonString = file.readAsStringSync();
    if (jsonString.isNullOrEmpty) {
      throw Exception('JSON String is null or empty to get Env');
    }

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
  } on Exception catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print('$s');
    return null;
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return null;
  }
}
