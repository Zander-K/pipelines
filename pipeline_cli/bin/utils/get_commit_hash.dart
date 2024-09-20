import 'dart:io';

import '../export.dart';

/// Returns a [String]? with the last commit hash of a given [branchName].
String? getLastCommitHash(String branch) {
  return _getLastCommitSha(Globals.sourceRepo, branch);
}

String? _getLastCommitSha(
  String repo,
  String branchName,
) {
  try {
    var result = Process.runSync(
      'gh',
      [
        'api',
        'repos/$repo/commits?sha=$branchName',
        '--jq',
        '.[0].sha',
      ],
      runInShell: true,
    );

    if (result.stderr.contains('gh')) {
      throw GhException(result.stderr);
    }

    if (result.exitCode != 0) {
      throw CommitHashException(
          'Error fetching the last commit SHA: ${result.stderr}');
    }

    var lastCommitSha = result.stdout.trim();

    if (lastCommitSha == null) {
      throw CommitHashException('Failed to retrieve the last commit SHA.');
    }

    return result.stdout.trim();
  } on CommitHashException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  } on GhException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    exit(1);
  } catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    return null;
  }
}
