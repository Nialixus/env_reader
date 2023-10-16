part of 'package:env_reader/env_reader.dart';

/// A utility class for encrypting and decrypting data using AES-GCM encryption.
///
/// The [EnvEncryption] class provides methods to encrypt and decrypt data
/// using a provided key. It uses the AES-GCM encryption algorithm for secure
/// encryption and decryption.
class EnvEncryption {
  /// Constructs an [EnvEncryption] instance with the specified encryption [key].
  const EnvEncryption(this.key);

  /// The encryption key used for encryption and decryption.
  final String key;

  /// The AES-GCM cipher used for encryption and decryption with a 256-bit key.
  static final AesGcm cipher = AesGcm.with256bits();

  /// Asynchronously generates the secret key for encryption and decryption based on the provided [key].
  ///
  /// The [key] is hashed using SHA-256 to derive the secret key.
  Future<SecretKey> get secretKey async {
    final hash = await Sha256().hash(utf8.encode(key));
    return SecretKey(hash.bytes);
  }

  /// Asynchronously encrypts the [data] using AES-GCM encryption with the generated secret key.
  ///
  /// Returns the encrypted data in the form of a base64-encoded string.
  Future<String> encrypt(String data) async {
    final result = await cipher.encryptString(
      data,
      secretKey: await secretKey,
    );
    return '${base64Encode(result.cipherText)}.${base64Encode(result.nonce)}.${base64Encode(result.mac.bytes)}';
  }

  /// Asynchronously decrypts the [data] using AES-GCM decryption with the generated secret key.
  ///
  /// The [data] is expected to be in the format: "cipherText.nonce.mac".
  Future<String> decrypt(String data) async {
    final decoded = data.split('.');
    return await cipher.decryptString(
      SecretBox(base64Decode(decoded.first),
          nonce: base64Decode(decoded[1]),
          mac: Mac(base64Decode(decoded.last))),
      secretKey: await secretKey,
    );
  }
}
