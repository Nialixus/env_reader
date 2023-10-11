part of '../env_reader.dart';

/// A function to add your [input] into .gitignore file in the same directory.
void insertGitignore({required ArgResults from}) {
  bool insert = from["pubspec"];
  if (insert) {
    File gitignore = File('.gitignore');
    String input = from["input"]!.toString();
    String? output = from["output"]?.toString();
    List<String> lines = gitignore.readAsLinesSync();
    bool inputExisted = false;
    bool outputExisted = false;

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains(input)) {
        inputExisted = true;
        break;
      }
    }

    if (output != null) {
      for (var item in lines) {
        if (item.contains(output)) {
          outputExisted = true;
          break;
        }
      }
    }

    if (!inputExisted) {
      String comment = "# Env Reader related";
      int index =
          lines.lastIndexWhere((line) => line.trim().startsWith(comment));
      if (index != -1) {
        lines.insert(index + 1, input);
      } else {
        lines.insert(0, "$comment\n$input");
      }
    }

    if (!outputExisted && output != null) {
      String comment = "# Env Reader related";
      int index =
          lines.lastIndexWhere((line) => line.trim().startsWith(comment));
      String export = outputExisted ? "" : output;
      if (index != -1) {
        lines.insert(index + 1, export);
      } else {
        lines.insert(0, "$comment\n$export");
      }
    }

    gitignore.writeAsStringSync(lines.join('\n'));
  }
}
