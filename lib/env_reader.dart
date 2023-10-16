/// A simple utility for reading and parsing environment variables from a .env file
///
/// This library provides a way to load environment variables from a .env file
/// and parse them into a Map<String, dynamic>, allowing you to easily access environment values
/// in your Dart application.
///
/// Example:
/// ```dart
/// // Loading env data
/// await Env.load(
///   EnvFileLoader(File('.env'))
/// );
///
/// // Using env data
/// String? api = Env.read<String>("API_KEY");
/// int port = Env.read<int>("PORT") ?? 8080;
/// bool isDebug = Env.read<bool>("DEBUG") ?? false;
/// ```
library env_reader;

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:env_reader/src/env_encryption.dart';
import 'package:env_reader/src/env_parser.dart';
import 'package:http/http.dart';

part 'package:env_reader/src/env_loader.dart';

/// A utility class for reading environment variables from .env source into your dart project.
class Env {
  /// Default instance of [EnvReader] used to read environment variables.
  static EnvReader instance = EnvReader();

  /// Loads environment variables from .env source.
  ///
  /// The [source] parameter specifies where's the .env took place.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvFileLoader(File('.env')),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  static Future<void> load(EnvLoader source, [String? key]) =>
      instance.load(source, key);

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

/// An instance to load and parse environment variables from .env into dart object.
class EnvReader {
  /// Loaded value of .env
  ///
  /// ```dart
  /// String? rawValue = EnvReader().value;
  /// ```
  String? value;

  /// Loads environment variables from .env source.
  ///
  /// The [source] parameter specifies where's the .env file took place.
  ///
  ///  ```dart
  /// await Env.load(
  ///   EnvFileLoader(File('.env')),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  Future<void> load(EnvLoader source, [String? key]) async {
    try {
      value = await source.data(key);
    } catch (e) {
      log("\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Unable to load data\u001b[0m 💥\n$e\n\n");
    }
  }

  /// Parse environment variables into a json structured map.
  ///
  /// ```dart
  /// Map<String, dynamic> json = EnvReader().toJson;
  /// ```
  Map<String, dynamic> get toJson => EnvParser(input: value ?? '').output;

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
      return toJson[key];
    } catch (e) {
      return null;
    }
  }
}
