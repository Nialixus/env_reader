// ignore_for_file: avoid_print
import 'package:args/args.dart';
import 'package:encryptor/encryptor.dart';
import 'package:universal_file/universal_file.dart';

part 'src/file.dart';
part 'src/pubspec.dart';
part 'src/json.dart';
part 'src/gitignore.dart';

/// Dart runner for [EnvReader] library.
void main(List<String> arguments) async {
  ArgParser runner = ArgParser()
    ..addOption('input', abbr: 'i', help: 'Input path of the .env file', mandatory: true)
    ..addOption('password', abbr: 'p', help: 'Password for encryption & decryption', mandatory: true)
    ..addOption('output', abbr: 'o', help: 'Custom output path for the encrypted .env file', defaultsTo: 'assets/env/')
    ..addOption('model', help: 'Generate model.dart file to your desired path')
    ..addFlag('help', abbr: 'h', help: 'Print this usage information')
    ..addFlag('null-safety', defaultsTo: false, negatable: false, help: 'Make the model null safety')
    ..addFlag('pubspec', defaultsTo: true, help: 'Inserting asset path to pubspec.yaml')
    ..addFlag('gitignore', defaultsTo: true, help: 'Inserting .env input file into .gitignore');
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
