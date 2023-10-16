part of '../../env_reader.dart';

/// A class to help user load their .env data from asset.
///
/// ```dart
/// await Env.load(
///   EnvAssetLoader('assets/env/.env'),
///   'MyOptionalSecretKey'
/// );
/// ```
class EnvAssetLoader extends EnvLoader<String> {
  /// Loading .env data from asset.
  ///
  /// ```dart
  /// await Env.load(
  ///   EnvAssetLoader('assets/env/.env'),
  ///   'MyOptionalSecretKey'
  /// );
  /// ```
  const EnvAssetLoader(super.source);

  @override
  Future<String> data([String? key]) async {
    String data = await rootBundle.loadString(source);
    return key != null ? await EnvEncryption(key).decrypt(data) : data;
  }
}
