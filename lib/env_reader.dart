/// A simple utility for reading and parsing environment variables from a .env file.
///
/// This library provides a way to load environment variables from a .env file
/// and parse them into a Map<String, dynamic>, allowing you to easily access environment values
/// in your Flutter application.
///
/// Example:
/// ```dart
/// // Loading env data
/// await Env.load(
///   EnvAssetLoader('assets/env/.env'),
///   'MyOptionalSecretKey');
///
/// // Using env data
/// String? api = Env.read<String>("API_KEY");
/// int port = Env.read<int>("PORT") ?? 8080;
/// bool isDebug = Env.read<bool>("DEBUG") ?? false;
/// ```
library env_reader;

import 'dart:async';
import 'package:flutter/services.dart';
import 'env_reader_core.dart';
export 'env_reader_core.dart' hide EnvParser, EnvEncryption;
part 'src/flutter/env_loader.dart';
