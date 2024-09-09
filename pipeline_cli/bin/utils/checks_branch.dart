import 'dart:io';

import '../const/export_const.dart';

bool checksBranch(String branch) {
  try {
    ProcessResult result = Process.runSync(
      'gh',
      ['api', 'repos/${Globals.repository}/branches/$branch'],
    );

    if (result.exitCode == 0) {
      print('Branch found');
      return true;
    } else {
      print('Branch not found');
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
