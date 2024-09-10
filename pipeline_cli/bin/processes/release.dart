import 'dart:io';
import 'package:path/path.dart' as path;

import '../const/defaults.dart';
import '../extensions/string.dart';
import '../utils/create_sdet_tag.dart';

void release({
  required String? title,
  required String? notes,
  required String? tag,
  required String? repo,
  required String? token,
  required List<String>? assets,
  bool? isInteractive,
}) {
  try {
    var inputs = {};

    inputs = _getInputs(
      tag: tag,
      title: title,
      notes: notes,
      repo: repo,
      token: token,
      assets: assets,
      isInteractive: isInteractive ?? true,
    );

    if (inputs.isEmpty) {
      print('No inputs provided.');
      return;
    }

    final generatedTag = createSDETTag();

    final releaseTag = inputs['tag'] ?? generatedTag;
    final releaseTitle = inputs['title'] ?? releaseTag;
    final releaseNotes = inputs['notes'] ?? Defaults.notes;
    final releaseTargetRepo = inputs['repo'] ?? Defaults.repo;
    final releaseSourceToken = inputs['token'] ?? Defaults.token;
    List<String>? paths = inputs['paths'];

    final releasePaths = <String>[];
    if (paths != null && paths.isNotEmpty) {
      print('Zipping files...');
      for (var path in paths) {
        final zipPath = generateAssetFile(path) ?? '';

        releasePaths.add(zipPath);
      }
      print('Zipping complete.');
    }

    print('Creating GitHub release...');
    List<String> releaseCommand = [
      'release',
      'create',
      releaseTag,
      ...releasePaths,
      '--repo',
      releaseTargetRepo,
      '--title',
      releaseTitle,
      '--notes',
      releaseNotes
    ];

    Map<String, String>? envVars = {
      'GH_TOKEN': releaseSourceToken ?? Defaults.token,
    };

    var releaseResult = Process.runSync(
      'gh',
      releaseCommand,
      environment: envVars,
    );

    if (releaseResult.exitCode != 0) {
      print('Error creating GitHub release: ${releaseResult.stderr}');
      return;
    }

    print('Release created successfully: ${releaseResult.stdout}');
  } catch (e, s) {
    print('An error occurred: $e, $s');
  }
}

Map<String, dynamic> _getInputs({
  String? title,
  String? notes,
  String? tag,
  String? repo,
  String? token,
  List<String>? assets,
  bool isInteractive = true,
}) {
  if (tag.isNull) {
    if (isInteractive) {
      tag = promptTag();
    } else {
      tag = null;
    }
  }

  if (title.isNull) {
    if (isInteractive) {
      title = promptTitle();

      if (title.isNull) {
        title = tag;
      }
    } else {
      title = tag;
    }
  }

  if (notes.isNull) {
    if (isInteractive) {
      notes = promptNotes();
    } else {
      notes = null;
    }
  }

  if (repo.isNull) {
    if (isInteractive) {
      repo = promptRepo();
    } else {
      repo = null;
    }
  }

  if (token.isNull) {
    if (isInteractive) {
      token = promptToken();
    } else {
      token = null;
    }
  }

  List<String>? paths;
  if (assets == null || assets.isEmpty) {
    if (isInteractive) {
      paths = promptPaths();
    } else {
      paths = null;
    }
  } else {
    paths = assets;
  }

  return {
    'tag': tag,
    'title': title,
    'notes': notes,
    'repo': repo,
    'token': token,
    'paths': paths,
  };
}

String? promptTag() {
  print(
      'Enter the tag for the release (defaults to automatically increments): ');
  String? input = stdin.readLineSync();
  final tag = (input == null || input.isEmpty) ? null : input;

  return tag;
}

String? promptTitle() {
  print('Enter the title for the release (defaults to tag): ');
  String? input = stdin.readLineSync();
  final title = (input == null || input.isEmpty) ? null : input;

  return title;
}

String? promptNotes() {
  print('Enter the release notes (defaults to ${Defaults.notes}): ');
  String? input = stdin.readLineSync();
  final notes = (input == null || input.isEmpty) ? null : input;

  return notes;
}

String? promptRepo() {
  print('Enter the GitHub repository (defaults to ${Defaults.repo}): ');
  String? input = stdin.readLineSync();
  final repo = (input == null || input.isEmpty) ? null : input;

  return repo;
}

String? promptToken() {
  print('Enter your GitHub token (default token will be used if left blank): ');
  String? input = stdin.readLineSync();
  final token = (input == null || input.isEmpty) ? null : input;

  return token;
}

List<String>? promptPaths() {
  List<String> paths = [];

  while (true) {
    print(
        'Enter the path to a file or directory to include in the release (or press Enter to finish): ');
    String? path = stdin.readLineSync();
    if (path == null || path.isEmpty) {
      break;
    }
    paths.add(path);
  }

  if (paths.isEmpty) {
    return null;
  }

  return paths;
}

String? generateAssetFile(String filePath) {
  if (filePath.endsWith('apk') || filePath.endsWith('ipa')) {
    return filePath;
  }

  final dir = _getDirectoryPath(filePath);
  final baseName = path.basenameWithoutExtension(filePath);

  String zipFileName = '$baseName.zip';
  final zipPath = '$dir/$zipFileName';

  var result = Process.runSync('zip', ['-r', zipPath, filePath]);

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
