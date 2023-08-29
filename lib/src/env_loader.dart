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
  string,
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

  /// Loading encrypted .env from asset used in flutter project.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.asset('assets/env/.env'),
  ///   password: "MyStrongPassword");
  /// ```
  static EnvAssetLoader asset(String source) => EnvAssetLoader(source);

  /// Loading encrypted .env from file. Make sure this file is accessible in your project.
  /// If its not, it will throws `PathNotFoundException`.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.file(File('.env')),
  ///   password: "MyStrongPassword");
  /// ```
  static EnvFileLoader file(File source) => EnvFileLoader(source);

  /// Loading encrypted .env from file from memory.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.memory(Uint8List.fromList([123,456,789])),
  ///   password: "MyStrongPassword");
  /// ```
  static EnvMemoryLoader memory(Uint8List source) => EnvMemoryLoader(source);

  /// Loading encrypted .env from file from network.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.network(Uri.parse('https://my.repo.dir/sub/.env')),
  ///   password: "MyStrongPassword");
  /// ```
  static EnvNetworkLoader network(Uri source) => EnvNetworkLoader(source);

  /// Loading encrypted .env from file from string.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.string('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
  ///   password: "MyStrongPassword");
  /// ```
  static EnvStringLoader string(String source) => EnvStringLoader(source);
}

/// A class to help user load their encrypted .env from asset. Suitable for flutter project.
class EnvAssetLoader extends EnvLoader<String> {
  /// Loading encrypted .env from asset used in flutter project.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.asset('assets/env/.env'),
  ///   password: "MyStrongPassword");
  /// ```
  const EnvAssetLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.asset;
}

/// A class to help user load their encrypted .env from file.
///
/// ```dart
/// await Env.load(
///   source: EnvLoader.file(File('.env')),
///   password: "MyStrongPassword");
/// ```
class EnvFileLoader extends EnvLoader<File> {
  /// Loading encrypted .env from file. Make sure this file is accessible in your project.
  /// If its not, it will throws `PathNotFoundException`.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.file(File('.env')),
  ///   password: "MyStrongPassword");
  /// ```
  const EnvFileLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.file;
}

/// A class to help user load their encrypted .env from [Uint8List].
///
/// ```dart
/// await Env.load(
///   source: EnvLoader.memory(Uint8List.fromList([123,456,789])),
///   password: "MyStrongPassword");
/// ```
class EnvMemoryLoader extends EnvLoader<Uint8List> {
  /// Loading encrypted .env from file from memory.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.memory(Uint8List.fromList([123,456,789])),
  ///   password: "MyStrongPassword");
  /// ```
  const EnvMemoryLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.memory;
}

/// A class to help user load their encrypted .env from network.
///
/// ```dart
/// await Env.load(
///   source: EnvLoader.network(Uri.parse('https://my.repo.dir/sub/.env')),
///   password: "MyStrongPassword");
/// ```
class EnvNetworkLoader extends EnvLoader<Uri> {
  /// Loading encrypted .env from file from network.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.network(Uri.parse('https://my.repo.dir/sub/.env')),
  ///   password: "MyStrongPassword");
  /// ```
  const EnvNetworkLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.network;
}

/// A class to help user load their encrypted .env from string.
///
/// ```dart
/// await Env.load(
///   source: EnvLoader.string('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
///   password: "MyStrongPassword");
/// ```
class EnvStringLoader extends EnvLoader<String> {
  /// Loading encrypted .env from file from string.
  ///
  /// ```dart
  /// await Env.load(
  ///   source: EnvLoader.string('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
  ///   password: "MyStrongPassword");
  /// ```
  const EnvStringLoader(super.source);

  @override
  EnvLoaderType type() => EnvLoaderType.string;
}
