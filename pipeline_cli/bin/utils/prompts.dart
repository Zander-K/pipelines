import 'dart:io';

import '../export.dart';

class Prompts {
  static String branch() {
    print(
        "No branch specified. Enter a branch name (or press Enter to use 'develop'): ");
    String? input = stdin.readLineSync()?.trim();

    final branch = (input == null || input.isEmpty) ? 'develop' : input;

    return branch;
  }

  static String? promptTag() {
    print(
        'Enter the tag for the release (defaults to automatically increments): ');
    String? input = stdin.readLineSync();
    final tag = (input == null || input.isEmpty) ? null : input;

    return tag;
  }

  static String? promptTitle() {
    print('Enter the title for the release (defaults to tag): ');
    String? input = stdin.readLineSync();
    final title = (input == null || input.isEmpty) ? null : input;

    return title;
  }

  static String? promptNotes() {
    print('Enter the release notes (defaults to ${Defaults.notes}): ');
    String? input = stdin.readLineSync();
    final notes = (input == null || input.isEmpty) ? null : input;

    return notes;
  }

  static String? promptRepo() {
    print('Enter the GitHub repository (defaults to ${Defaults.repo}): ');
    String? input = stdin.readLineSync();
    final repo = (input == null || input.isEmpty) ? null : input;

    return repo;
  }

  static String? promptToken() {
    print(
        'Enter your GitHub token (default token will be used if left blank): ');
    String? input = stdin.readLineSync();
    final token = (input == null || input.isEmpty) ? null : input;

    return token;
  }

  static List<String>? promptPaths() {
    List<String> paths = [];

    while (true) {
      print(
          'Enter the path to a file or directory to include in the release (or press Enter to finish): ');
      String? path = stdin.readLineSync();
      if (path == null || path.isEmpty) {
        break;
      }
      paths.add(path);
    }

    if (paths.isEmpty) {
      return null;
    }

    return paths;
  }
}
