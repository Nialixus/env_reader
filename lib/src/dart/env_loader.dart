part of '../../env_reader_core.dart';

/// Used to refering where's the .env file came from.
abstract class EnvLoader<T extends Object> {
  /// Creates an [EnvLoader] instance with the specified [source].
  ///
  /// ```dart
  /// EnvLoader<String>('assets/env/.env');
  /// ```
  const EnvLoader(this.source);

  /// The source of .env object
  final T source;

  /// Parse [source] into [String] data.
  Future<String> data([String? key]);
}

/// A class to help user load their .env data from [File].
///
/// ```dart
/// await Env.load(
///   EnvFileLoader(File('.env')),
///   'MyOptionalSecretKey'
/// );
/// ```
class EnvFileLoader extends EnvLoader<File> {
  /// Loading .env data from [File]. Make sure this file is accessible in your project.
  /// If its not, it will throws `PathNotFoundException`.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvFileLoader(File('.env')),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  const EnvFileLoader(super.source);

  @override
  Future<String> data([String? key]) async {
    String data = source.readAsStringSync();
    return key != null ? await EnvEncryption(key).decrypt(data) : data;
  }
}

/// A class to help user load their .env data from [Uint8List].
///
/// ```dart
/// await Env.load(
///   EnvMemoryLeader(Uint8List.fromList([123,456,789])),
///   'MyOptionalSecretKey'
/// );
/// ```
class EnvMemoryLoader extends EnvLoader<Uint8List> {
  /// Loading .env data from [Uint8List].
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvMemoryLoader(Uint8List.fromList([123,456,789])),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  const EnvMemoryLoader(super.source);

  @override
  Future<String> data([String? key]) async {
    String data = String.fromCharCodes(source);
    return key != null ? await EnvEncryption(key).decrypt(data) : data;
  }
}

/// A class to help user load their .env data from network.
///
/// ```dart
/// await Env.load(
///   EnvNetworkLoader(Uri.parse('https://my.repo.dir/sub/.env')),
///   'MyOptionalSecretKey'
/// );
/// ```
class EnvNetworkLoader extends EnvLoader<Uri> {
  /// Loading .env data from network.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvNetworkLoader(Uri.parse('https://my.repo.dir/sub/.env')),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  const EnvNetworkLoader(super.source);

  @override
  Future<String> data([String? key]) async {
    Response response = await get(source);
    return key != null
        ? await EnvEncryption(key).decrypt(response.body)
        : response.body;
  }
}

/// A class to help user load their .env data from [String].
///
/// ```dart
/// await Env.load(
///   EnvStringLoader('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
///   'MyOptionalSecretKey'
/// );
/// ```
class EnvStringLoader extends EnvLoader<String> {
  /// Loading .env data from [String].
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvStringLoader('GDE6V1uW1u0Z+LmxdgzW/vHLg1p/CXnYW08...'),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  const EnvStringLoader(super.source);

  @override
  Future<String> data([String? key]) async {
    return key != null
        ? await EnvEncryption(key).decrypt(source.toString())
        : source.toString();
  }
}
