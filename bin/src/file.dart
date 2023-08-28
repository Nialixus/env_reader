// ignore_for_file: avoid_print
part of '../env_reader.dart';

/// A function to take the .env file from given [input] into a more secured version inside [directory].
void insertFile({required ArgResults from}) {
  String input = from['input']!.toString();
  String output = from["output"]!.toString();
  String target = output.contains("/")
      ? output.replaceAll(RegExp(r'/[^/]+$'), "/")
      : Directory.current.path;
  String password = from['password']!.toString();
  String data = File(input).readAsStringSync();
  Directory directory = Directory(target)..createSync(recursive: true);
  String name = output.endsWith("/")
      ? (input.contains("/") ? input.split("/").last : input)
      : output.contains("/")
          ? output.split("/").last
          : output;
  File asset = File(directory.path + name)
    ..writeAsStringSync(Encryptor.encrypt(password, data));
  print(
      "\x1B[32m$input\x1B[0m successfully encrypted into \x1B[34m${asset.path}\x1B[0m 🚀");
}
