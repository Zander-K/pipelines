import 'dart:io';

import '../const/export_const.dart';

String? getLastCommitHash(String branchName) {
  var lastCommitSha =
      _getLastCommitSha(Globals.owner, Globals.repo, branchName);

  if (lastCommitSha != null) {
    return lastCommitSha;
  } else {
    print('Failed to retrieve the last commit SHA.');
    return null;
  }
}

String? _getLastCommitSha(
  String owner,
  String repo,
  String branchName,
) {
  try {
    var result = Process.runSync('gh', [
      'api',
      'repos/$owner/$repo/commits?sha=$branchName',
      '--jq',
      '.[0].sha'
    ]);

    if (result.exitCode != 0) {
      print('Error fetching the last commit SHA: ${result.stderr}');
      return null;
    }

    return result.stdout.trim();
  } catch (e) {
    print('Error in get_commit_hash: $e');
    return null;
  }
}
