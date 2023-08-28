/// A simple utility for reading and parsing environment variables from a .env file.
///
/// This library provides a way to load environment variables from a .env file
/// and parse them into a map, allowing you to easily access environment values
/// in your Flutter application.
///
/// Example:
/// ```dart
/// Future<void> main(List<String> arguments) async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await Env.instance.load(password: "my strong password");
///   runApp(...);
/// }
///
/// String? api = Env.read<String>("API_KEY");
/// int port = Env.read<int>("PORT") ?? 8080;
/// bool isDebug = Env.read<bool>("DEBUG") ?? false;
/// ```
library env_reader;

import 'dart:async';
import 'package:encryptor/encryptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:universal_file/universal_file.dart';

part 'src/env_loader.dart';

/// A utility class for reading environment variables from an encrypted .env source.
class Env {
  /// The instance of [EnvReader] used to read environment variables.
  static EnvReader instance = EnvReader();

  /// Loads environment variables from an encrypted .env source.
  ///
  /// The [source] parameter specifies where's the encrypted .env took place.
  ///
  /// ```dart
  /// Future<void> main(List<String> arguments) async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Env.load(
  ///     source: EnvLoader.asset('assets/env/.env'),
  ///     password: "my strong password");
  ///   runApp(...);
  /// }
  /// ```
  static Future<void> load(
          {required EnvLoader source, required String password}) =>
      instance.load(source: source, password: password);

  /// Reads an environment variable value of type [T] from the loaded environment.
  ///
  /// Returns the value associated with the specified [key], or `null` if the key
  /// is not found or there was an error while reading the environment.
  ///
  /// ```dart
  /// // example
  /// String? api = Env.read("API_KEY");
  /// int port = Env.read<int>("PORT") ?? 8080;
  /// ```
  static T? read<T extends Object>(String key) => instance.read<T>(key);
}

/// A class for loading and parsing environment variables from an encrypted .env source.
class EnvReader {
  /// Decrypted value of its loaded environment configuration.
  ///
  /// ```dart
  /// String? env = EnvReader().value;
  /// ```
  String? value;

  /// Loads environment variables from an encrypted .env source.
  ///
  /// The [source] parameter specifies where's the encrypted .env took place.
  ///
  /// ```dart
  /// Future<void> main(List<String> arguments) async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Env.load(
  ///     source: EnvLoader.asset('assets/env/.env'),
  ///     password: "my strong password");
  ///   runApp(...);
  /// }
  /// ```
  Future<void> load(
      {required EnvLoader source, required String password}) async {
    try {
      if (source is EnvAssetLoader) {
        String data = await rootBundle.loadString(source.source);
        value = Encryptor.decrypt(password, data);
      } else if (source is EnvFileLoader) {
        String data = await (source.source).readAsString();
        value = Encryptor.decrypt(password, data);
      } else if (source is EnvMemoryLoader) {
        String data = String.fromCharCodes(source.source);
        value = Encryptor.decrypt(password, data);
      } else if (source is EnvNetworkLoader) {
        Response response = await get(source.source);
        value = Encryptor.decrypt(password, response.body);
      } else {
        value = Encryptor.decrypt(password, source.source.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            "\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Unable to load data\u001b[0m 💥\n$e\n\n");
      }
      value = null;
    }
  }

  /// Parses environment variables into a json structured map.
  ///
  /// ```dart
  /// Map<String, dynamic> json = Env.instance.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    final lines = (value ?? "").trim().split('\n');

    for (final line in lines) {
      if (line.trim().startsWith('#')) {
        continue;
      }

      try {
        final parts = line.split('=');
        if (parts.length >= 2) {
          final key = parts[0].trim();
          final value = parts.sublist(1).join('=').trim();

          if (int.tryParse(value) != null) {
            data[key] = int.parse(value);
          } else if (double.tryParse(value) != null) {
            data[key] = double.parse(value);
          } else if (value == 'true' || value == 'false') {
            data[key] = value == 'true';
          } else {
            data[key] = value;
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(
              "\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Parsing failed\u001b[0m 💥\n$e\n\n");
        }
      }
    }
    return data;
  }

  /// Reads an environment variable value of type [T] from the loaded environment.
  ///
  /// Returns the value associated with the specified [key], or `null` if the key
  /// is not found or there was an error while reading the environment.
  ///
  /// ```dart
  /// // example
  /// final env = EnvReader();
  /// String? api = env.read("API_KEY");
  /// int port = env.read<int>("PORT") ?? 8080;
  /// ```
  T? read<T extends Object>(String key) {
    try {
      return toJson()[key];
    } catch (e) {
      return null;
    }
  }
}
