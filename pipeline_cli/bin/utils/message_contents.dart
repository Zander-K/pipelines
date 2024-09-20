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
    final newTitle = title ?? 'New Build Distribution';
    final newBody = body ??
        'A new build is out. \n Download the file using the artifact URL.';
    final lastCommit = getLastCommitHash(branch);
    final platformType = getPlatformType(workflowName);
    final totalBuildTimeFormatted = getTotalBuildTime(workflowName);
    final versionBuildDetails = getVersionAndBuildDetails(workflowName);
    final appName = getAppName(workflowName);
    final pubspec = getPubspecInstalledPackages(workflowName);
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
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New Build Distribution',
      body: '''
A new build was distributed.

Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.qaGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New Grosvenor QA Distribution',
      body: '''
A new *QA* build was distributed for Grosvenor.

Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.qaMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New MeccaBingo QA Distribution',
      body: '''
A new *QA* build was distributed for MeccaBingo.

Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.betaGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New Grosvenor BETA Distribution',
      body: '''
A new *BETA* build was distributed for Grosvenor.

Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.betaMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New MeccaBingo BETA Distribution',
      body: '''
A new *BETA* build was distributed for MeccaBingo.

Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.prodGrosDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New Grosvenor Production Distribution',
      body: '''
A new *production* build has been published for Grosvenor.

 Download the file using the artifact URL below.\n
''',
    );
  }

  factory MessageContents.prodMeccaDistribution({
    required String branch,
    required String workflowName,
  }) {
    return MessageContents._(
      branch: branch,
      workflowName: workflowName,
      title: 'New MeccaBingo Production Distribution',
      body: '''
A new *production* build has been published for MeccaBingo.

 Download the file using the artifact URL below.\n
''',
    );
  }

  String getContents() {
    var outputBuffer = StringBuffer();

    outputBuffer.writeln('**$title**\n');
    outputBuffer.writeln(body);
    outputBuffer
        .writeln('**-----------------------------------------------------**');
    outputBuffer.writeln(
        '${'** 📅\tCurrent Date:'.padRight(30)}** ${dateAndTime.date} **');
    outputBuffer.writeln(
        '${'** ⏱️\tCurrent Time:'.padRight(30)}** ${dateAndTime.time} SAST **');
    outputBuffer
        .writeln('**-----------------------------------------------------**');
    outputBuffer.writeln(
        '${'** 🛠️\tWorkflow Name:'.padRight(30)}** [$workflowName](https://github.com/${Globals.repository}/commit/$lastCommit/checks) **');
    outputBuffer
        .writeln('${'** 📱\tPlatform:'.padRight(30)}** $platformType **');
    outputBuffer.writeln('${'** 🏷️\tApp Name:'.padRight(30)}** $appName **');
    outputBuffer.writeln(
        '${'** 🔖\tCommit Hash:'.padRight(30)}** [$lastCommit](https://github.com/${Globals.repository}/commit/$lastCommit) **');
    outputBuffer.writeln(
        '${'** 🪵\tBranch Name:'.padRight(30)}** [$branch](https://github.com/${Globals.repository}/tree/$branch) **');
    outputBuffer.writeln(
        '${'** ⏱️\tTotal Build Time:'.padRight(30)}** $totalBuildTimeFormatted **');
    outputBuffer.writeln(
        '${'** 🔢\t${versionBuildDetails.label}:'.padRight(30)}** ${versionBuildDetails.versionOrBuild} **');
    outputBuffer.writeln(
        '${'** 🦋\tFlutter Version:'.padRight(30)}** $flutterVersion **');
    outputBuffer
        .writeln('${'** 🎯\tDart Version:'.padRight(30)}** $dartVersion **\n');
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
