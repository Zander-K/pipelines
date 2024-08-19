import 'dart:io';

Future<String> getLastCommitHash() async {
  var owner = 'Zander-K';
  var repo = 'pipelines';

  var lastCommitSha = await _getLastBranchCommitSha(owner, repo);

  if (lastCommitSha != null) {
    print('Last Commit SHA: $lastCommitSha');
    return lastCommitSha;
  } else {
    print('Failed to retrieve the last commit SHA.');
    return 'Failed to retrieve the last commit SHA.';
  }
}

Future<String?> _getLastBranchCommitSha(String owner, String repo) async {
  try {
    var branchName = _getBranchNameFromEnv();
    if (branchName == null) {
      print('This workflow was not triggered by a branch.');
      return '';
    }

    var commitResult = Process.runSync('gh', [
      'api',
      'repos/$owner/$repo/commits',
      '--jq',
      '.[0].sha',
      '--paginate',
      '-F',
      'sha=$branchName'
    ]);

    if (commitResult.exitCode != 0) {
      print(
          'Error fetching the latest commit from branch $branchName: ${commitResult.stderr}');
      return null;
    }

    return commitResult.stdout.trim();
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

String? _getBranchNameFromEnv() {
  var githubRef = Platform.environment['GITHUB_REF'];
  if (githubRef != null && githubRef.contains('refs/heads/')) {
    return githubRef.split('refs/heads/').last.trim();
  }
  return null;
}
