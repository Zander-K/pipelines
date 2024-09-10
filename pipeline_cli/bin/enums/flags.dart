enum Flags {
  generate(
    'generate',
    'g',
    'Generate an output file with info (Used with -b to specify the branch to use).',
    false,
  ),
  help('help', 'h', 'Show help for `pipe`', false),
  verbose('verbose', 'v', 'Show verbose details', false),
  version('version', 'V', 'Show versioning', false),
  welcome('welcome', 'w', 'Welcome Info', false),
  release('release', 'r',
      'Generates release for SDET, used with --source-token', false),
  interactive('interactive', 'i', 'Enable or disable interactive CLI', true),
  unknown('', '', '', false);

  const Flags(
    this.flag,
    this.abbr,
    this.info,
    this.neg,
  );

  final String flag;
  final String abbr;
  final String info;
  final bool neg;
}
