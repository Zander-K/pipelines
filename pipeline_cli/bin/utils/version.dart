import 'dart:io';

import '../export.dart';

void printVersion(bool showVerbose) {
  stdout.writeln(
      'pipeline version: $versionNumber ${showVerbose ? '(Aug 2024)' : ''}');
}
