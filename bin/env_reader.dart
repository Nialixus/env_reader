// ignore_for_file: avoid_print
import 'dart:io';

import 'package:args/args.dart';
import 'package:encryptor/encryptor.dart';

part 'src/file.dart';
part 'src/pubspec.dart';
part 'src/json.dart';
part 'src/gitignore.dart';

/// Dart runner for [EnvReader] library.
void main(List<String> arguments) async {
  ArgParser runner = ArgParser()
    ..addOption('input',
        abbr: 'i', help: 'Input path of the .env file', mandatory: true)
    ..addOption('output',
        abbr: 'o', help: 'Output path for the encrypted .env file')
    ..addOption('key',
        abbr: 's', help: 'Secret key for encryption & decryption')
    ..addOption('model', help: 'Generate dart model to your desired file path')
    ..addFlag('null-safety',
        defaultsTo: false, negatable: false, help: 'Make the model null safety')
    ..addFlag('obfuscate',
        defaultsTo: true, help: 'Obfuscating generated values of model')
    ..addFlag('pubspec',
        defaultsTo: true, help: 'Inserting asset path to pubspec.yaml')
    ..addFlag('gitignore',
        defaultsTo: true,
        help: 'Inserting .env input & output file into .gitignore')
    ..addFlag('help',
        defaultsTo: false,
        abbr: 'h',
        negatable: false,
        help: 'Print this usage information');
  try {
    ArgResults argument = runner.parse(arguments);
    if (argument["help"]) {
      throw '\u001b[0mAvailable commands:';
    } else {
      insertJson(from: argument);
      insertPubspec(from: argument);
      insertGitignore(from: argument);
      insertFile(from: argument);
    }
  } catch (e) {
    print("\n\u001b[31m$e\u001b[0m\n");
    print(runner.usage);
    print('\n\u001b[32mdart run\u001b[0m '
        '\u001b[36menv_reader\u001b[0m '
        '--input=\u001b[33m".env"\u001b[0m '
        '--password=\u001b[33m"MyStrongPassword"\u001b[0m '
        '--model=\u001b[33m"lib/src/env_model.dart"\u001b[0m '
        '--null-safety');
  }
}
