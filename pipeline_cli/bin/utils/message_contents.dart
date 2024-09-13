import '../export.dart';

class MessageContents {
  MessageContents({
    required this.title,
    required this.body,
    required this.branch,
    required this.workflowName,
    required this.dateAndTime,
    required this.platformType,
    required this.appName,
    required this.lastCommit,
    required this.totalBuildTimeFormatted,
    required this.versionBuildDetails,
    required this.flutterVersion,
    required this.dartVersion,
    required this.pubspecContents,
  });

  final String? title;
  late final String? body;
  final DateAndTime dateAndTime;
  final String workflowName;
  final String platformType;
  final String? appName;
  final String? lastCommit;
  final String branch;
  final String totalBuildTimeFormatted;
  final VersionBuildDetails versionBuildDetails;
  final String? flutterVersion;
  final String? dartVersion;
  final String? pubspecContents;

  factory MessageContents._({
    required String branch,
    required String workflowName,
    String? title,
    String? body,
  }) {
    final newTitle = title ?? 'A new build is out.';
    final newBody = body ?? 'Download the artifact using the button below.';
    final lastCommit = getLastCommitHash(branch);
    final platformType = getPlatformType(workflowName);
    final pubspecDir = getPubspecDirectory(workflowName);
    final totalBuildTimeFormatted = getTotalBuildTime(workflowName);
    final versionBuildDetails =
        getVersionAndBuildDetails(workflowName, pubspecDir);
    final appName = getAppName(pubspecDir);
    final pubspec = getPubspecInstalledPackages(pubspecDir);
    final flutterVersion = pubspec?.flutter;
    final dartVersion = pubspec?.dart;
    final pubspecContents = pubspec?.contents;
    final currentDateAndTime = getDateTime();

    return MessageContents(
      title: newTitle,
      body: newBody,
      dateAndTime: currentDateAndTime,
      workflowName: workflowName,
      platformType: platformType,
      appName: appName,
      lastCommit: lastCommit,
      branch: branch,
      totalBuildTimeFormatted: totalBuildTimeFormatted,
      versionBuildDetails: versionBuildDetails,
      flutterVersion: flutterVersion,
      dartVersion: dartVersion,
      pubspecContents: pubspecContents,
    );
  }

  factory MessageContents.defaultDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new build was distributed.',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.qaGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new QA build was distributed for Grosvenor.',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.qaMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new QA build was distributed for Mecca Bingo',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.betaGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new BETA build was distributed for Grosvenor',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.betaMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new BETA build was distributed for Mecca Bingo',
      body: '''
Download the artifact using the button below.\n
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.prodGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new *production* build has been published for Grosvenor',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  factory MessageContents.prodMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    final lastCommit = getLastCommitHash(branch);

    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'A new *production* build has been published for Mecca Bingo',
      body: '''
[$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit )\n
Last Commit\n
[$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit)\n
Download the artifact using the link below.\n
''',
    );
  }

  String getContents() {
    var outputBuffer = StringBuffer();

    outputBuffer.writeln('$title\n');
    outputBuffer.writeln(body);
    outputBuffer
        .writeln('**-----------------------------------------------------**');
    outputBuffer.writeln('** 📅\tCurrent Date: \t\t** ${dateAndTime.date} **');
    outputBuffer
        .writeln('** ⏱️\tCurrent Time: \t\t** ${dateAndTime.time} SAST **');
    outputBuffer
        .writeln('**-----------------------------------------------------**');
    outputBuffer.writeln('** 🛠️\tWorkflow Name: \t\t** $workflowName **');
    outputBuffer.writeln('** 📱\tPlatform: \t\t\t** $platformType **');
    outputBuffer.writeln('** 🏷️\tApp Name: \t\t** $appName **');
    outputBuffer.writeln('** 🔖\tCommit Hash: \t\t** $lastCommit **');
    outputBuffer.writeln('** 🪵\tBranch Name: \t\t** $branch **');
    outputBuffer
        .writeln('** ⏱️\tTotal Build Time: \t** $totalBuildTimeFormatted **');
    outputBuffer.writeln(
        '** 🔢\t${versionBuildDetails.label}: \t** ${versionBuildDetails.versionOrBuild} **');
    outputBuffer.writeln('** 🦋\tFlutter Version: \t\t** $flutterVersion **');
    outputBuffer.writeln('** 🎯\tDart Version: \t\t\t** $dartVersion **\n');
    outputBuffer
        .writeln('**-----------------------------------------------------**');

    outputBuffer.writeln('**PUBSPEC.LOCK CONTENTS: Installed Packages**');
    outputBuffer
        .writeln('**-----------------------------------------------------**\n');
    outputBuffer.write(pubspecContents);
    outputBuffer
        .writeln('**-----------------------------------------------------**');

    return outputBuffer.toString();
  }
}
