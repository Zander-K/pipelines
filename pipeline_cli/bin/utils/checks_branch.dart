import 'dart:io';

bool checksBranch(String branch) {
  try {
    String repository = 'rankengineering/rank_mobile_core';

    ProcessResult result = Process.runSync(
      'gh',
      ['api', 'repos/$repository/branches/$branch'],
    );

    if (result.exitCode == 0) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print("Error while checking the branch: $e");
    return false;
  }
}

void main(List<String> args) {
  final iss = checksBranch('develop');

  print(iss);
}
