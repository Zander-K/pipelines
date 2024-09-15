import 'package:args/args.dart';

/// Print usage of CLI
/// Usage:
/// -g, --generate    Generate an output file with info (Used with -b to specify the branch to use).
/// -h, --help        Show help for `pipe`
/// -v, --verbose     Show verbose details
/// -V, --version     Show versioning
/// -w, --welcome     Welcome Info
/// -b, --branch      Branch name of workflow (Used with -g)
void printUsage(ArgParser argParser) {
  print('Usage: ');
  print(argParser.usage);
}
