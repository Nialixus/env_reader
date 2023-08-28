part of '../env_reader.dart';

/// A function to add your [input] into .gitignore file in the same directory.
void insertGitignore({required ArgResults from}) {
  bool insert = from["pubspec"] ?? true;
  if (insert) {
    File gitignore = File('.gitignore');
    String input = from["input"]!.toString();
    List<String> lines = gitignore.readAsLinesSync();
    bool existed = false;

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains(input)) {
        existed = true;
        break;
      }
    }

    if (!existed) {
      String comment = "# Env Reader related";
      int index =
          lines.lastIndexWhere((line) => line.trim().startsWith(comment));
      if (index != -1) {
        lines.insert(index + 1, input);
      } else {
        lines.insert(0, "$comment\n$input\n");
      }
    }

    gitignore.writeAsStringSync(lines.join('\n'));
  }
}
