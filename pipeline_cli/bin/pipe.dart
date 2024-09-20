import 'dart:io';
import 'export.dart';

void main(List<String> arguments) {
  final argParser = parser();

  try {
    final args = argParser.parse(arguments);
    if (args.arguments.isEmpty) printUsage(argParser);
    bool showVerbose = args.wasParsed(Flags.verbose.flag);

    if (args.wasParsed(Flags.generate.flag)) {
      String? branch = args[Options.branch.flag];

      generate(
        branch: branch,
      );
    }

    if (args.wasParsed(Flags.release.flag)) {
      String? title = args[Options.title.flag];
      String? notes = args[Options.notes.flag];
      String? tag = args[Options.tag.flag];
      String? repo = args[Options.repo.flag];
      String? token = args[Options.token.flag];
      List<String>? assets = args[Options.assets.flag];
      bool? isInteractive = args[Flags.interactive.flag];
      String? env = args[Options.environment.flag];
      String? branch = args[Options.branch.flag];

      release(
        title: title,
        notes: notes,
        tag: tag,
        repo: repo,
        token: token,
        assets: assets,
        isInteractive: isInteractive,
        env: env,
        branch: branch,
      );
    }

    if (args.wasParsed(Flags.help.flag)) {
      printUsage(argParser);
    }
    if (args.wasParsed(Flags.version.flag)) {
      printVersion(showVerbose);
    }
    if (args.wasParsed(Flags.welcome.flag)) {
      printWelcome();
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    printUsage(argParser);
  } on ArgumentError catch (e) {
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
