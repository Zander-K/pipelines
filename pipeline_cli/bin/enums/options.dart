enum Options {
  commit('commit', 'c', 'he last commit SHA'),
  workflow('workflow', 'w', 'The name of the workflow'),
  labels('labels', 'l', 'Comma-separated list of labels'),
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
