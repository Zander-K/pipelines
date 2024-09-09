enum Options {
  branch('branch', 'b', 'Branch name of workflow (Used with -g)'),
  unknown('', '', '');

  const Options(
    this.flag,
    this.abbr,
    this.help,
  );

  final String flag;
  final String abbr;
  final String help;
}
