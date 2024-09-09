import 'dart:io';

import '../export.dart';

void printVersion(bool showVerbose) {
  stdout.writeln(
      'pipe version: $versionNumber ${showVerbose ? '(Aug 2024)' : ''}');
}
