import 'dart:io';

import '../const/export_const.dart';

/// Return a [bool] on whether a given branch is found in a repo
bool checksBranch(String branch) {
  try {
    ProcessResult result = Process.runSync(
      'gh',
      ['api', 'repos/${Globals.repository}/branches/$branch'],
    );

    if (result.exitCode == 0) {
      return true;
    } else {
      return false;
    }
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
    return false;
  }
}
