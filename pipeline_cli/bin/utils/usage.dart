import 'package:args/args.dart';

/// Print usage of CLI
/// Usage:
/// -g, --generate                    Generate and extract build info (Used with -b to specify the branch to use).
/// -h, --help                        Show help options for `pipe`
/// -v, --verbose                     Show verbose details
/// -V, --version                     Show versioning
/// -w, --welcome                     Welcome Info
/// -r, --release                     Generates release for SDET, used with --source-token
/// -i, --[no-]interactive            Enable or disable interactive CLI
///                                   (defaults to on)
/// -b, --branch                      Branch name of workflow (Used with -g, defaults to `develop`)
///     --title                       Release title (defaults to tag)
///     --notes                       Release notes or path
///     --tag                         Release tag (used to manually set a tag)
///     --target-repo                 Release target <owner/repo>
///     --source-token (mandatory)    Token from Source Repo to be used for release; Used alongside -r
///     --assets                      Release assets file paths
/// -e, --environment                 Specifies the environment to use for release (dev, stg, or prod - defaults to stg)
void printUsage(ArgParser argParser) {
  print('Usage: ');
  print(argParser.usage);
}
