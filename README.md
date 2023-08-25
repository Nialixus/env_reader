Absolutely, thank you for the additional information. Here's the updated `README.md` file content with the necessary changes:

```markdown
# env_reader

A simple Flutter package for loading and parsing environment variables from a .env file. It provides a convenient way to access environment variables in your Flutter application.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  env_reader: ^1.0.0
```

## Usage

1. Create a `.env` file in your project directory and add your environment variables with the format `KEY=VALUE`. Example:

```plaintext
API_KEY=your_api_key
DEBUG=true
```

2. Make sure to add `.env` to your `.gitignore` file to prevent sensitive information from being committed to version control.

3. Import the package in your Dart file:

```dart
import 'package:env_reader/env_reader.dart';
```

4. Load and read environment variables in your application code:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables from the .env file
  await Env.instance.load();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Env Reader Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access environment variables using the Env class
    final apiKey = Env.read<String>('API_KEY');
    final debugMode = Env.read<bool>('DEBUG');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Env Reader Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('API Key: $apiKey'),
            Text('Debug Mode: $debugMode'),
          ],
        ),
      ),
    );
  }
}
```

Please make sure to replace `'API_KEY'` and `'DEBUG'` with your actual environment variable names.

## Features and Notes

- This package provides a straightforward way to load and access environment variables in your Flutter application.
- It supports common environment variable types like `String`, `int`, `double`, and `bool`.
- Comment lines in the `.env` file, starting with `#`, are ignored.
- If an environment variable's value cannot be parsed, it is treated as a `String`.

## Contribution

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request on [GitHub](https://github.com/your-repo/env_reader).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

Again, replace `"your-repo"` with your actual GitHub repository name.