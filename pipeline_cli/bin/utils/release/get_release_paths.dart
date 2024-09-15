import 'dart:io';
import 'package:path/path.dart' as path;

import '../../export.dart';

String? _generateAssetFile(String filePath) {
  if (filePath.endsWith('apk') || filePath.endsWith('ipa')) {
    return filePath;
  }

  String finalPath = filePath;

  if (Platform.environment.containsKey('VSCODE_CWD')) {
    if (filePath.startsWith('./')) {
      finalPath = '.$filePath';
    }
  }

  final dir = _getDirectoryPath(finalPath);
  final baseName = path.basenameWithoutExtension(finalPath);

  String zipFileName = '$baseName.zip';
  final zipPath = '$dir/$zipFileName';

  var result = Process.runSync('zip', ['-r', zipPath, finalPath]);

  if (result.exitCode != 0) {
    print('Error while zipping files.');
    print(result.stderr);
    return null;
  }

  return zipPath;
}

String _getDirectoryPath(String filePath) {
  return path.dirname(filePath);
}

List<String>? getReleasePaths(List<String>? paths) {
  if (paths == null || paths.isEmpty) {
    return null;
  }

  final cleanPaths = _cleanReleasePaths(paths);
  if (cleanPaths == null) {
    return null;
  }

  final releasePaths = <String>[];

  if (cleanPaths.isNotEmpty) {
    print('Zipping files...');
    for (var path in cleanPaths) {
      final newPath = _generateAssetFile(path) ?? '';

      releasePaths.add(newPath);
    }
    print('Zipping complete.');
  }

  return releasePaths;
}

List<String>? _cleanReleasePaths(List<String> paths) {
  final newList =
      paths.where((element) => element.isNotNullAndNotEmpty).toList();

  return newList;
}
