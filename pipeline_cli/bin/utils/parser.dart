import 'package:args/args.dart';

import '../enums/export_enums.dart';

ArgParser parser() {
  final argParser = ArgParser();
  argParser
    // ..addFlag(
    //   Flags.generate.flag,
    //   abbr: Flags.generate.abbr,
    //   help: Flags.generate.info,
    //   negatable: Flags.generate.neg,
    // )
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
    );

  argParser.addMultiOption(
    Flags.generate.flag,
    abbr: Flags.generate.abbr,
    help: Flags.generate.info,
    splitCommas: true,
  );

  return argParser;
}
