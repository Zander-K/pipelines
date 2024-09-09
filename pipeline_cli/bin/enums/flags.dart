enum Flags {
  generate('generate', 'g', 'Generate file', false),
  help('help', 'h', 'Show help', false),
  verbose('verbose', 'v', 'Show verbose', false),
  version('version', 'V', 'Show version', false),
  welcome('welcome', 'W', 'Welcome Page', false),
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
