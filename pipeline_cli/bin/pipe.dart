import 'dart:io';

import 'export.dart';

void main(List<String> arguments) {
  final argParser = parser();

  try {
    final args = argParser.parse(arguments);

    if (args.arguments.isEmpty) printUsage(argParser);

    bool showVerbose = args.wasParsed(Flags.verbose.flag);

    if (args.wasParsed(Flags.generate.flag)) {
      final String? workflowName = args['workflow'];
      final String? labels = args['labels'];
      final String? lastCommit = args['commit'];

      if (workflowName == null || labels == null || lastCommit == null) {
        print(
            'Usage: pipe -g --workflow <commit> --labels <workflow> --commit <labels>');
        printUsage(argParser);
        return;
      }

      generate(
        workflow: workflowName,
        labels: labels,
        commit: lastCommit,
      );
    }
    if (args.wasParsed(Flags.help.flag)) {
      printUsage(argParser);
    }
    if (args.wasParsed(Flags.verbose.flag)) {}
    if (args.wasParsed(Flags.version.flag)) {
      printVersion(showVerbose);
    }
    if (args.wasParsed(Flags.welcome.flag)) {}
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  } on Exception catch (e, s) {
    print('Unexpected error: ');
    print('Error: $e');
    print('Stack Trace: $s');
  } finally {
    exit(0);
  }
}
