part of '../env_reader.dart';

/// A function to check wether `- assets/env/` already exist in `pubspec.yaml` or not.
/// If not its inserting the path giver, and if its already there, this will do nothing.
void insertPubspec() {
  File pubspecFile = File('pubspec.yaml');
  List<String> lines = pubspecFile.readAsLinesSync();
  bool foundAssets = false;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim().startsWith('assets:')) {
      if (!lines[i + 1].contains('- assets/env/')) {
        lines.insert(i + 1, '    - assets/env/');
      }
      foundAssets = true;
      break;
    }
  }

  if (!foundAssets) {
    int lastFlutterLineIndex =
        lines.lastIndexWhere((line) => line.trim() == 'flutter:');
    if (lastFlutterLineIndex != -1) {
      lines.insert(lastFlutterLineIndex + 1, '  assets:');
      lines.insert(lastFlutterLineIndex + 2, '    - assets/env/');
    }
  }

  pubspecFile.writeAsStringSync(lines.join('\n'));
}
