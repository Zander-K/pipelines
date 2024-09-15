import '../export.dart';

class Defaults {
  static String title = '';
  static String notes = 'Release notes';
  static String tag = 'v1.0.0';

  /// <OWNER/REPO> for the Target Repo
  static String repo = Globals.targetRepo;

  /// Token secret from the source repo
  static String token = '';

  /// Paths to the assets to be included in a release
  static List<String>? paths;
}
