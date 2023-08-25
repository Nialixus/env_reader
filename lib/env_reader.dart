/// A simple utility for reading and parsing environment variables from a .env file.
///
/// This library provides a way to load environment variables from a .env file
/// and parse them into a map, allowing you to easily access environment values
/// in your Flutter application.
///
/// Example:
/// ```dart
/// await Env.instance.load();
/// String? myValue = Env.read<String>("MY_VALUE");
/// int? myInt = Env.read<int>("MY_INT");
/// bool? myBool = Env.read<bool>("MY_BOOL");
/// ```
library env_reader;

import 'dart:async';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A utility class for reading environment variables from a .env file.
class Env {
  /// The instance of [EnvReader] used to read environment variables.
  static EnvReader instance = EnvReader();

  /// Reads an environment variable value of type [T] from the loaded environment.
  ///
  /// Returns the value associated with the specified [key], or `null` if the key
  /// is not found or there was an error while reading the environment.
  static T? read<T extends Object>(String key) {
    try {
      return instance.toJson()[key];
    } catch (e) {
      return null;
    }
  }
}

/// A class for loading and parsing environment variables from a .env file.
class EnvReader {
  /// The content of the loaded .env file.
  String? value;

  /// Loads environment variables from a .env file.
  ///
  /// The [path] parameter specifies the path to the .env file. By default, it
  /// looks for the .env file in the parent directory.
  Future<void> load({String? path}) async {
    final source = path ?? await rootBundle.loadString('packages/env_reader/.env');
    try {
      value = await XFile(source).readAsString();
    } catch (e) {
      print(e);
      value = null;
    }
  }

  /// Parses environment variables into a map.
  ///
  /// This method reads the environment variables from the loaded .env file,
  /// parses their values, and stores them in a map. It returns the map of
  /// environment variable names and their parsed values.
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
        if (kDebugMode) print("EnvException: $e");
      }
    }
    return data;
  }
}
