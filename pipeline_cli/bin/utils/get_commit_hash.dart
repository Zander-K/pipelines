import 'dart:io';

Future<String> getLastCommitHash() async {
  var owner = 'Zander-K';
  var repo = 'pipelines';

  var lastCommitSha = await _getLastCommitSha(owner, repo);

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

Future<String?> _getLastCommitSha(String owner, String repo) async {
  try {
    var branchName = _getBranchNameFromEnv();
    if (branchName == null) {
      print('This workflow was not triggered by a branch.');
      return '';
    }

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

String? _getBranchNameFromEnv() {
  return Platform.environment['GITHUB_SHA'];
  // var githubRef = Platform.environment['GITHUB_REF'];

  // if (githubRef != null) {
  //   if (githubRef.startsWith('refs/heads/')) {
  //     return githubRef.split('refs/heads/').last.trim();
  //   } else if (githubRef.startsWith('refs/pull/')) {
  //     return Platform.environment['GITHUB_HEAD_REF'];
  //   }
  // }
  // return null;
}

void main() async {
  var owner = 'Zander-K'; // Replace with your GitHub username
  var repo = 'pipelines'; // Replace with your repository name

  var branchName = _getBranchNameFromEnv();
  if (branchName == null) {
    print('Failed to retrieve the branch name.');
    return;
  }

  var lastCommitSha = await _getLastCommitSha(owner, repo);

  if (lastCommitSha != null) {
    print('Last Commit SHA on branch $branchName: $lastCommitSha');
  } else {
    print('Failed to retrieve the last commit SHA.');
  }
}
