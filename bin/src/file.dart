// ignore_for_file: avoid_print
part of '../env_reader.dart';

/// A function to take the .env file from given [path] into a more secured version inside [directory].
void insertFile({required ArgResults from}) {
  String input = from['input']!.toString();
  String output = from["output"]!.toString().contains("/")
      ? from["output"]!.toString().replaceAll(RegExp(r'/[^/]+$'), "/")
      : Directory.current.path;
  String password = from['password']!.toString();
  String data = File(input).readAsStringSync();
  Directory directory = Directory(output)..createSync(recursive: true);
  String name = input.contains("/") ? input.split("/").last : input;
  File asset = File(directory.path + name)..writeAsStringSync(Encryptor.encrypt(password, data));
  print("\x1B[32m$name\x1B[0m successfully secured into \x1B[34m${asset.path}\x1B[0m 🚀");
}
