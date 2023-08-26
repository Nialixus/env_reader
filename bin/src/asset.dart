// ignore_for_file: avoid_print
part of '../env_reader.dart';

/// A function to take the .env file from given [path] into a more secured version inside [directory].
void insertAsset({required ArgResults argument}) {
  String path = argument['path']!.toString();
  String password = argument['password']!.toString();
  String data = File(path).readAsStringSync();
  Directory directory = Directory('assets/env/')..createSync(recursive: true);
  String name = path.contains("/") ? path.split("/").last : path;
  File asset = File(directory.path + name)
    ..writeAsStringSync(Encryptor.encrypt(password, data));
  print(
      "\x1B[32m$name\x1B[0m successfully secured into \x1B[34m${asset.path}\x1B[0m 🚀");
}
