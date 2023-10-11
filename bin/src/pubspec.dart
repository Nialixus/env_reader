// ignore_for_file: avoid_print
part of '../env_reader.dart';

/// A function to check wether the output path (if its's an assets directory) already exist in `pubspec.yaml` or not.
/// If it hasn't, this function inserting the output path given into your pubspec.yaml, and if its already there, this will do nothing.
void insertPubspec({required ArgResults from}) {
  bool insert = from["pubspec"] ?? true;
  String input = from["input"]!.toString();
  String? output = from['output']?.toString();
  if (insert && output != null) {
    String output =
        from["output"]!.toString().replaceAll(RegExp(r'/[^/]+$'), "/");
    if (output.startsWith("assets/")) {
      File pubspec = File('pubspec.yaml');
      List<String> lines = pubspec.readAsLinesSync();
      bool existed = false;

      for (int i = 0; i < lines.length; i++) {
        if (lines[i].contains("- $output")) {
          existed = true;
          break;
        }
      }

      if (!existed) {
        int flutterIndex =
            lines.lastIndexWhere((line) => line.trim() == 'flutter:');
        int assetsIndex =
            lines.lastIndexWhere((line) => line.trim() == 'assets:');
        if (flutterIndex == -1) {
          lines.insert(lines.length - 1, 'flutter:\n  assets:\n    - $output');
        } else {
          if (assetsIndex == -1) {
            lines.insert(flutterIndex + 1, '  assets:\n    - $output');
          } else {
            lines.insert(assetsIndex + 1, '    - $output');
          }
        }

        pubspec.writeAsStringSync(lines.join('\n'));
      }
    } else {
      print(
          "\u001b[33m--pubspec\u001b[0m \u001b[2mflag ignored, due to output not in assets directory\u001b[0m");
      print(
          "\u001b[2mThis make the $input not accesible for every flutter platform\u001b[0m");
    }
  }
}
