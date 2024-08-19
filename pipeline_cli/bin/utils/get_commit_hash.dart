import 'dart:io';

String getLastCommitHash(String branchName) {
  var owner = 'Zander-K';
  var repo = 'pipelines';

  var lastCommitSha = _getLastCommitSha(owner, repo, branchName);

  if (lastCommitSha != null) {
    return lastCommitSha;
  } else {
    return 'Failed to retrieve the last commit SHA.';
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
    print('Error: $e');
    return null;
  }
}

void main() async {
  var owner = 'Zander-K'; // Replace with your GitHub username
  var repo = 'pipelines'; // Replace with your repository name

  var branchName = 'test-pr';

  // var branchName = _getBranchNameFromEnv();
  // if (branchName == null) {
  //   print('Failed to retrieve the branch name.');
  //   return;
  // }

  var lastCommitSha = _getLastCommitSha(owner, repo, branchName);

  if (lastCommitSha != null) {
    print('Last Commit SHA on branch $branchName: $lastCommitSha');
  } else {
    print('Failed to retrieve the last commit SHA.');
  }
}
