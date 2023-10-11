// Env Reader Auto-Generated Model File
// Created at 2023-10-11 15:28:35.710424
// 🍔 [Buy me a coffee](https://www.buymeacoffee.com/nialixus) 🚀
import 'package:env_reader/env_reader.dart';

/// This class represents environment variables parsed from the .env file.
/// Each static variable corresponds to an environment variable,
/// with default values provided for safety
/// `false` for [bool], `0` for [int], `0.0` for [double] and `VARIABLE_NAME` for [String].
class EnvModel {
  /// Value of `DATABASE_URL` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('DATABASE_URL') ?? 'DATABASE_URL';
  /// ```
  static String databaseUrl =
      Env.read<String>('DATABASE_URL') ?? 'DATABASE_URL';

  /// Value of `API_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('API_KEY') ?? 'API_KEY';
  /// ```
  static String apiKey = Env.read<String>('API_KEY') ?? 'API_KEY';

  /// Value of `DEBUG` in environment variable. This is equal to
  /// ```dart
  /// Env.read<bool>('DEBUG') ?? false;
  /// ```
  static bool debug = Env.read<bool>('DEBUG') ?? false;

  /// Value of `SECRET_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SECRET_KEY') ?? 'SECRET_KEY';
  /// ```
  static String secretKey = Env.read<String>('SECRET_KEY') ?? 'SECRET_KEY';

  /// Value of `JWT_SECRET` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('JWT_SECRET') ?? 'JWT_SECRET';
  /// ```
  static String jwtSecret = Env.read<String>('JWT_SECRET') ?? 'JWT_SECRET';

  /// Value of `PORT` in environment variable. This is equal to
  /// ```dart
  /// Env.read<int>('PORT') ?? 0;
  /// ```
  static int port = Env.read<int>('PORT') ?? 0;

  /// Value of `APP_NAME` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('APP_NAME') ?? 'APP_NAME';
  /// ```
  static String appName = Env.read<String>('APP_NAME') ?? 'APP_NAME';

  /// Value of `AWS_ACCESS_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('AWS_ACCESS_KEY') ?? 'AWS_ACCESS_KEY';
  /// ```
  static String awsAccessKey =
      Env.read<String>('AWS_ACCESS_KEY') ?? 'AWS_ACCESS_KEY';

  /// Value of `AWS_SECRET_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('AWS_SECRET_KEY') ?? 'AWS_SECRET_KEY';
  /// ```
  static String awsSecretKey =
      Env.read<String>('AWS_SECRET_KEY') ?? 'AWS_SECRET_KEY';

  /// Value of `REDIS_URL` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('REDIS_URL') ?? 'REDIS_URL';
  /// ```
  static String redisUrl = Env.read<String>('REDIS_URL') ?? 'REDIS_URL';

  /// Value of `MAIL_USERNAME` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('MAIL_USERNAME') ?? 'MAIL_USERNAME';
  /// ```
  static String mailUsername =
      Env.read<String>('MAIL_USERNAME') ?? 'MAIL_USERNAME';

  /// Value of `MAIL_PASSWORD` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('MAIL_PASSWORD') ?? 'MAIL_PASSWORD';
  /// ```
  static String mailPassword =
      Env.read<String>('MAIL_PASSWORD') ?? 'MAIL_PASSWORD';

  /// Value of `GOOGLE_CLIENT_ID` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('GOOGLE_CLIENT_ID') ?? 'GOOGLE_CLIENT_ID';
  /// ```
  static String googleClientId =
      Env.read<String>('GOOGLE_CLIENT_ID') ?? 'GOOGLE_CLIENT_ID';

  /// Value of `GOOGLE_CLIENT_SECRET` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('GOOGLE_CLIENT_SECRET') ?? 'GOOGLE_CLIENT_SECRET';
  /// ```
  static String googleClientSecret =
      Env.read<String>('GOOGLE_CLIENT_SECRET') ?? 'GOOGLE_CLIENT_SECRET';

  /// Value of `FACEBOOK_APP_ID` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('FACEBOOK_APP_ID') ?? 'FACEBOOK_APP_ID';
  /// ```
  static String facebookAppId =
      Env.read<String>('FACEBOOK_APP_ID') ?? 'FACEBOOK_APP_ID';

  /// Value of `FACEBOOK_APP_SECRET` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('FACEBOOK_APP_SECRET') ?? 'FACEBOOK_APP_SECRET';
  /// ```
  static String facebookAppSecret =
      Env.read<String>('FACEBOOK_APP_SECRET') ?? 'FACEBOOK_APP_SECRET';

  /// Value of `STRIPE_SECRET_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('STRIPE_SECRET_KEY') ?? 'STRIPE_SECRET_KEY';
  /// ```
  static String stripeSecretKey =
      Env.read<String>('STRIPE_SECRET_KEY') ?? 'STRIPE_SECRET_KEY';

  /// Value of `S3_BUCKET_NAME` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('S3_BUCKET_NAME') ?? 'S3_BUCKET_NAME';
  /// ```
  static String s3BucketName =
      Env.read<String>('S3_BUCKET_NAME') ?? 'S3_BUCKET_NAME';

  /// Value of `MONGO_URI` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('MONGO_URI') ?? 'MONGO_URI';
  /// ```
  static String mongoUri = Env.read<String>('MONGO_URI') ?? 'MONGO_URI';

  /// Value of `SENDGRID_API_KEY` in environment variable. This is equal to
  /// ```dart
  /// Env.read<String>('SENDGRID_API_KEY') ?? 'SENDGRID_API_KEY';
  /// ```
  static String sendgridApiKey =
      Env.read<String>('SENDGRID_API_KEY') ?? 'SENDGRID_API_KEY';
}
