part of '../env_reader.dart';

/// Enumeration representing various types of sources for loading encrypted .env
enum EnvLoaderType {
  /// Load environment configuration from an asset.
  asset,

  /// Load environment configuration from a file.
  file,

  /// Load environment configuration from memory.
  memory,

  /// Load environment configuration from a network source.
  network,

  /// Load environment configuration from a string.
  string;

  /// Default constructor of [EnvLoaderType].
  const EnvLoaderType();
}

/// Used to refering where's the encrypted .env file came from.
abstract class EnvLoader<T extends Object> {
  /// Creates an [EnvLoader] instance with the specified [source].
  ///
  /// ```dart
  /// EnvLoader<String>('assets/env/.env');
  /// ```
  const EnvLoader(this.source);

  /// The source of encrypted .env object
  final T source;

  /// Indicating what type the encrypted .env is
  ///
  /// Consist of [EnvLoaderType.asset], [EnvLoaderType.file], [EnvLoaderType.memory], [EnvLoaderType.network] and [EnvLoaderType.string]
  EnvLoaderType type();
}

/// A class to help user load their .env data from [File].
///
/// ```dart
/// await Env.load(
///   EnvFileLoader(File('.env')),
///   "MyOptionalSecretKey");
/// ```
class EnvFileLoader extends EnvLoader<File> {
  /// Loading .env data from [File]. Make sure this file is accessible in your project.
  /// If its not, it will throws `PathNotFoundException`.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvFileLoader(File('.env')),
  ///   "MyOptionalSecretKey");
  /// ```
  const EnvFileLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.file;
}

/// A class to help user load their .env data from [Uint8List].
///
/// ```dart
/// await Env.load(
///   EnvMemoryLeader(Uint8List.fromList([123,456,789])),
///   "MyOptionalSecretKey");
/// ```
class EnvMemoryLoader extends EnvLoader<Uint8List> {
  /// Loading .env data from [Uint8List].
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvMemoryLoader(Uint8List.fromList([123,456,789])),
  ///   "MyOptionalSecretKey");
  /// ```
  const EnvMemoryLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.memory;
}

/// A class to help user load their .env data from network.
///
/// ```dart
/// await Env.load(
///   EnvNetworkLoader(Uri.parse('https://my.repo.dir/sub/.env')),
///   "MyOptionalSecretKey");
/// ```
class EnvNetworkLoader extends EnvLoader<Uri> {
  /// Loading .env data from network.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvNetworkLoader(Uri.parse('https://my.repo.dir/sub/.env')),
  ///   "MyOptionalSecretKey");
  /// ```
  const EnvNetworkLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.network;
}

/// A class to help user load their .env data from [String].
///
/// ```dart
/// await Env.load(
///   EnvStringLoader('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
///   "MyOptionalSecretKey");
/// ```
class EnvStringLoader extends EnvLoader<String> {
  /// Loading .env data from [String].
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvStringLoader('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
  ///   "MyOptionalSecretKey");
  /// ```
  const EnvStringLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.string;
}

/// A class to help user load their .env data from [String].
///
/// ```dart
/// await Env.load(
///   EnvAssetLoader('assets/env/.env'),
///   "MyOptionalSecretKey");
/// ```
class EnvAssetLoader extends EnvLoader<String> {
  /// Loading .env data from [String].
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvAssetLoader('assets/env/.env'),
  ///   "MyOptionalSecretKey");
  /// ```
  const EnvAssetLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.string;
}
