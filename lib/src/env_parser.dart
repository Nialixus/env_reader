import 'dart:developer';

export 'env_parser.dart' hide EnvParser;

/// A utility class for parsing environment variables from a given input string.
///
/// The [EnvParser] parses the input string, typically representing an
/// environment file, and extracts key-value pairs for environment variables.
///
/// Usage:
/// ```dart
/// String input = 'KEY1=value1';
/// Map<String, dynamic> output = EnvParser(input: input).output;
/// print(output['KEY1']); // value1
/// ```
class EnvParser {
  /// Constructs an [EnvParser] instance with the specified [input].
  ///
  /// The [input] parameter should be a string representing the contents of an
  /// environment file where each line follows the format 'key=value'.
  const EnvParser({required this.input});

  /// The input string representing the environment file.
  final String input;

  /// Parses the input and returns a map of environment variables and their values.
  ///
  /// This method processes the input string line by line, ignoring comment lines,
  /// and separates each line into a key-value pair. It attempts to parse the
  /// values into integers, floats, booleans, or keeps them as strings based on
  /// the parsing success.
  ///
  /// Returns a map of environment variable names (keys) and their corresponding
  /// values (parsed or as strings).
  Map<String, dynamic> get output {
    final data = <String, dynamic>{};
    // [1] Separate env file by line.
    final lines = input.trim().split('\n');

    for (int index = 0; index < lines.length; index++) {
      // [2] Ignoring comment line.
      if (lines[index].trim().startsWith('#')) {
        continue;
      }

      try {
        // [3] Separating key and value of env variable.
        final parts = lines[index].split('=');
        if (parts.length >= 2) {
          // [4] Get env key.
          final key = parts[0].trim();

          // [5] Get env value.
          final value = parts.sublist(1).join('=').trim();

          // [6] Try parsing value into integer.
          if (int.tryParse(value) != null) {
            data[key] = int.parse(value);
          }
          // [7] Try parsing value into float.
          else if (double.tryParse(value) != null) {
            data[key] = double.parse(value);
          }
          // [8] Try parsing value into boolean.
          else if (value == 'true' || value == 'false') {
            data[key] = value == 'true';
          }
          // [9] Set value as string.
          else {
            data[key] = value;
          }
        }
      } catch (e) {
        // [10] Tell user that env value was unable to be parsed.
        log("\n\n\u001b[1m[ENV_READER]\u001b[31m 💥 Parsing failed on line ${index + 1}\u001b[0m 💥\n$e\n\n");
      }
    }
    return data;
  }
}
