import 'package:args/args.dart';

import '../enums/export_enums.dart';

ArgParser parser() {
  final argParser = ArgParser();
  argParser
    ..addFlag(
      Flags.generate.flag,
      abbr: Flags.generate.abbr,
      help: Flags.generate.info,
      negatable: Flags.generate.neg,
    )
    ..addFlag(
      Flags.help.flag,
      abbr: Flags.help.abbr,
      help: Flags.help.info,
      negatable: Flags.help.neg,
    )
    ..addFlag(
      Flags.verbose.flag,
      abbr: Flags.verbose.abbr,
      help: Flags.verbose.info,
      negatable: Flags.verbose.neg,
    )
    ..addFlag(
      Flags.version.flag,
      abbr: Flags.version.abbr,
      help: Flags.version.info,
      negatable: Flags.version.neg,
    )
    ..addFlag(
      Flags.welcome.flag,
      abbr: Flags.welcome.abbr,
      help: Flags.welcome.info,
      negatable: Flags.welcome.neg,
    )
    ..addFlag(
      Flags.release.flag,
      abbr: Flags.release.abbr,
      help: Flags.release.info,
      negatable: Flags.release.neg,
    )
    ..addFlag(
      Flags.interactive.flag,
      abbr: Flags.interactive.abbr,
      help: Flags.interactive.info,
      negatable: Flags.interactive.neg,
      defaultsTo: true,
    )
    ..addOption(
      Options.branch.flag,
      abbr: Options.branch.abbr,
      help: Options.branch.help,
    )
    ..addOption(
      Options.title.flag,
      abbr: Options.title.abbr,
      help: Options.title.help,
    )
    ..addOption(
      Options.notes.flag,
      abbr: Options.notes.abbr,
      help: Options.notes.help,
    )
    ..addOption(
      Options.tag.flag,
      abbr: Options.tag.abbr,
      help: Options.tag.help,
    )
    ..addOption(
      Options.repo.flag,
      abbr: Options.repo.abbr,
      help: Options.repo.help,
    )
    ..addOption(
      Options.token.flag,
      abbr: Options.token.abbr,
      help: Options.token.help,
      mandatory: true,
    )
    ..addMultiOption(
      Options.assets.flag,
      abbr: Options.assets.abbr,
      help: Options.assets.help,
      splitCommas: true,
    );

  return argParser;
}
