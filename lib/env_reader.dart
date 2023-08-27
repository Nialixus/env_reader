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
import 'package:universal_file/universal_file.dart';

/// A utility class for reading environment variables from a .env file.
class Env {
  /// The instance of [EnvReader] used to read environment variables.
  static EnvReader instance = EnvReader();

  /// Loads environment variables from a .env file.
  ///
  /// The [asset] parameter specifies the path to the .env file in asset/env/ directory. By default, it
  /// sets to look for the `assets/env/.env` file.
  ///
  /// ```dart
  /// Future<void> main(List<String> arguments) async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Env.load(
  ///     path: "assets/env/.env",
  ///     password: "my strong password");
  ///   runApp(...);
  /// }
  /// ```
  static Future<void> load({String path = 'assets/env/.env', required String password}) =>
      instance.load(path: path, password: password);

  /// Reads an environment variable value of type [T] from the loaded environment.
  ///
  /// Returns the value associated with the specified [key], or `null` if the key
  /// is not found or there was an error while reading the environment.
  ///
  /// ```dart
  /// // example
  /// final api = Env.read("API_KEY");
  /// int port = Env.read<int>("PORT") ?? 8080;
  /// ```
  static T? read<T extends Object>(String key) => instance.read<T>(key);
}

/// A class for loading and parsing environment variables from a .env file.
class EnvReader {
  /// The raw content of the loaded .env file.
  ///
  /// ```dart
  /// String? env = Env.instance.value;
  /// ```
  String? value;

  /// Loads environment variables from a .env file.
  ///
  /// The [asset] parameter specifies the path to the .env file in asset/env/ directory. By default, it
  /// sets to look for the `assets/env/.env` file.
  ///
  /// ```dart
  /// Future<void> main(List<String> arguments) async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await EnvReader().load(
  ///     path: "assets/env/.env",
  ///     password: "my strong password");
  ///   runApp(...);
  /// }
  /// ```
  Future<void> load({required String path, required String password}) async {
    try {
      if (path.startsWith('assets/')) {
        String data = await rootBundle.loadString(path);
        value = Encryptor.decrypt(password, data);
      } else {
        final file = File(path)..createSync(recursive: true);
        value = Encryptor.decrypt(password, file.readAsStringSync());
      }
    } catch (e) {
      if (kDebugMode) {
        print("\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Unable to load data\u001b[0m 💥\n$e\n\n");
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
          print("\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Parsing failed\u001b[0m 💥\n$e\n\n");
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
  /// final api = env.read("API_KEY");
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
