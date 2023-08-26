# Env Reader

<a href='https://pub.dev/packages/env_reader'><img src='https://img.shields.io/pub/v/env_reader.svg?logo=flutter&color=blue&style=flat-square'/></a>\
\
Effortlessly manage and access secured environment variables across Flutter platforms using this dotenv reader.

## Feature
- **Simplified Access:** Easily load and retrieve environment variables from a .env file using a concise syntax 👌.   
- **Secure Handling:** Supports encrypted .env files, enhancing security by decrypting sensitive data during loading 🔓.  
- **Flexible Value Types:** Automatically parses environment values into appropriate data types, such as integers, floating-point numbers, and booleans 🕹.  
- **Streamlined Integration:** Integrate the library seamlessly into your Flutter project for all of its platform 🚀.

## Install

Run this command to add `env_reader` into your pubspec.yaml
```bash
dart pub add env_reader
```
  
now to activate the command line for `env_reader`, you gotta run this command
```bash
dart pub global activate env_reader
```

## Usage

First thing to do is making .env file in root directory of your project folder `same directory with pubspec.yaml`.
Also for suggestion add the .env in your .gitignore.
```env
# .env sample file
API_KEY=my-secret-api-key
DEBUG=true
PORT=8080
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
```

when you've done it, you will need to run this command.

```bash
dart run env_reader --path=".env" --password="my strong password"
```

Notice when you running this command you need to set `--password`, because this function make the .env file publicly accessible for all platfrom in `assets/env/` directory, so atleast you gotta encrypt it right 😉. The `--path` itself is where your original `.env` locate, where it will be turn into secured version in `assets/env/` path, just like this sample message.
```bash
.env successfully secured into assets/env/.env 🚀
```
so that result path is the asset path where we should set in loading the env_reader instance. 


Next step, we need to import this package like this.

```dart
import 'package:env_reader/env_reader.dart';
```

And loading the env_reader instance after ensuring WidgetsFlutterBinding to initialized.
```dart
Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.instance.load(
    asset: "assets/env/.env",
    password: "my strong password");

  runApp(...);
}
```

After everything has been set, we fetch the value from .env like this
```dart
String api = Env.read("API_KEY") ?? "Got'cha 😎";
bool debug = Env.read<bool>("DEBUG") ?? false;

Text(
  text: debug ? "🤫 pssst, this is my api key y'all\n\n$api" : "Nothing to see here 🤪",
  ),
);
```
## Addition
Currently this library only support on parsing `int`, `double`, `bool` and `String`.
You can also read the parsed .env in Map<String, dynamic> format by calling this
```dart
Map<String, dynamic> json = Env.instance.toJson();
```
or if you want to see the original content, you can call this
```dart
String? env = Env.instance.value;
```

## Example

- <a href="https://github.com/Nialixus/env_reader/blob/main/example/lib/main.dart">env_reader/example/lib/main.dart</a>
