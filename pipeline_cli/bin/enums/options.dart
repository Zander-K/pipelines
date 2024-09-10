enum Options {
  branch('branch', 'b', 'Branch name of workflow (Used with -g)'),
  title('title', null, 'Release title (defaults to tag)'),
  notes('notes', null, 'Release notes'),
  tag('tag', null, 'Release tag (used to manually set a tag)'),
  repo('target-repo', null, 'Release target <owner/repo>'),
  token('source-token', null,
      'Token from Source Repo to be used for release; Used alongside -r'),
  assets('assets', null, 'Release assets'),
  unknown('', '', '');

  const Options(
    this.flag,
    this.abbr,
    this.help,
  );

  final String flag;
  final String? abbr;
  final String help;
}
