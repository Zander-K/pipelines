import 'dart:io';

import '../const/export_const.dart';
import '../exceptions/branch.dart';

/// Return a [bool] on whether a given branch is found in a repo
void checksBranch(String branch) {
  try {
    ProcessResult result = Process.runSync(
      'gh',
      ['api', 'repos/${Globals.repository}/branches/$branch'],
    );

    if (result.exitCode == 0) {
      return;
    } else {
      throw BranchNotFoundException();
    }
  } on BranchNotFoundException catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
  } catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
  }
}
