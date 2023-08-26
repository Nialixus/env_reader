// ignore_for_file: avoid_print
import 'package:args/args.dart';
import 'package:encryptor/encryptor.dart';
import 'package:universal_file/universal_file.dart';

part 'src/pubspec.dart';
part 'src/asset.dart';

void main(List<String> arguments) async {
  ArgParser runner = ArgParser()
    ..addOption('path', help: 'Path to the .env file')
    ..addOption('password', help: 'Password for decryption');
  try {
    insertAsset(argument: runner.parse(arguments));
    insertPubspec();
  } catch (e) {
    print("\n$e\n");
    print(runner.usage);
    print('\ndart run env_reader --path=".env" --password="myPassword');
  }
}
