import 'dart:io';

import '../export.dart';

void release({
  required String? title,
  required String? notes,
  required String? tag,
  required String? repo,
  required String? token,
  required List<String>? assets,
  bool? isInteractive,
  required String? env,
  required String? branch,
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
      isInteractive: isInteractive ?? false,
    );

    if (inputs.isEmpty) {
      print('No inputs provided.');
      return;
    }

    var type = '';
    if (branch?.toLowerCase().contains('rc') ?? false) {
      type = 'RC';
    } else {
      type = 'QA';
    }

    final generatedTag = createSDETTag(
      env: env,
      type: type,
      branch: branch,
    );
    if (generatedTag.isEmpty) {
      print('Error. Tag is empty.');
      return;
    }

    final String? inputTag = inputs['tag'];
    final String? inputTitle = inputs['title'];
    final String? inputNotes = inputs['notes'];
    final String? inputTargetRepo = inputs['repo'];
    final String? inputSourceToken = inputs['token'];
    List<String>? paths = inputs['paths'] ?? [];

    final releaseNotesContents = getReleaseNotes(inputNotes ?? Defaults.notes);
    final releasePaths = getReleasePaths(paths);

    final String releaseTag = inputTag ?? generatedTag;
    final String releaseTitle = inputTitle ?? releaseTag;
    final String releaseTargetRepo = inputTargetRepo ?? Defaults.repo;
    final String releaseSourceToken = inputSourceToken ?? Defaults.token;

    print('Creating GitHub release...');
    List<String> releaseCommand = [
      'release',
      'create',
      releaseTag,
      ...?releasePaths,
      '--repo',
      releaseTargetRepo,
      '--title',
      releaseTitle,
      '--notes',
      releaseNotesContents
    ];

    Map<String, String>? envVars = {
      'GH_TOKEN': releaseSourceToken,
    };

    var result = Process.runSync(
      'gh',
      releaseCommand,
      environment: envVars,
    );

    if (result.stderr.contains('gh')) {
      throw GhException(result.stderr);
    }

    if (result.exitCode != 0) {
      print('Error creating GitHub release: ${result.stderr}');
      return;
    }

    print('Release created successfully: ${result.stdout}');
  } on GhException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    exit(1);
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
      tag = Prompts.promptTag();
    } else {
      tag = null;
    }
  }

  if (title.isNull) {
    if (isInteractive) {
      title = Prompts.promptTitle();

      if (title.isNull) {
        title = tag;
      }
    } else {
      title = tag;
    }
  }

  if (notes.isNull) {
    if (isInteractive) {
      notes = Prompts.promptNotes();
    } else {
      notes = null;
    }
  }

  if (repo.isNull) {
    if (isInteractive) {
      repo = Prompts.promptRepo();
    } else {
      repo = null;
    }
  }

  if (token.isNull) {
    if (isInteractive) {
      token = Prompts.promptToken();
    } else {
      token = null;
    }
  }

  List<String>? paths;
  if (assets == null || assets.isEmpty) {
    if (isInteractive) {
      paths = Prompts.promptPaths();
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
