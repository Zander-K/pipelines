import 'dart:io';

import '../export.dart';

/// Return a [bool] on whether a given [branch] is found in a repo.
bool checksBranch(String branch) {
  try {
    ProcessResult result = Process.runSync(
      'gh',
      ['api', 'repos/${Globals.sourceRepo}/branches/$branch'],
      runInShell: true,
    );

    if (result.stderr.contains('gh')) {
      throw GhException(result.stderr);
    }

    if (result.exitCode == 0) {
      return true;
    } else {
      return false;
    }
  } on GhException catch (e, s) {
    print('\n$e');
    print('Stack Trace:');
    print(s);
    exit(1);
  } catch (e, s) {
    print('Unexpected error: $e');
    print('Stack Trace:');
    print('$s');
    return false;
  }
}
