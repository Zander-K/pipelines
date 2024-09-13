import 'dart:io';

class Prompts {
  static String branch() {
    print(
        "No branch specified. Enter a branch name (or press Enter to use 'develop'): ");
    String? input = stdin.readLineSync()?.trim();

    final branch = (input == null || input.isEmpty) ? 'develop' : input;

    return branch;
  }
}
