# Env Reader

<a href='https://pub.dev/packages/env_reader'><img src='https://img.shields.io/pub/v/env_reader.svg?logo=flutter&color=blue&style=flat-square'/></a>\
\
Enhance the rock-solid integrity of your .env configuration by seamlessly encrypting and decrypting data sourced from a dynamic range of origins—be it assets, files, strings, memory, or networks—spanning a multitude of platforms. What's more, experience the sheer simplicity of generating Dart models directly from your .env data. Your configuration, fortified and efficient, ready to elevate your development journey. 🌟🛡️

## Features 🚀
- **Automated Magic:** Transform your .env files into dynamic Dart models effortlessly. Watch your codebase evolve with automatic model generation!. ✨
- **Seamless Integration:** Keep your pubspec.yaml and .gitignore in harmony with your .env files. Updates happen seamlessly, leaving you with more time to create. 🛠️ 
- **Fortified Encryption:** Shield your precious .env configurations from prying eyes with top-tier encryption. Your secrets remain yours. 🔒  
- **Data Diversity Unleashed:** Instantly harness the power of automatic data type conversion. From numbers to booleans, your app is empowered. 🎮
- **Versatile Sourcing**: Unleash your encrypted .env from various sources—assets, files, memory, network, and strings. It's all about choice. 🔄

Step into a realm where automation, security, and flexibility converge to elevate your coding experience. Discover how effortless and impactful .env management can be! 💎🔗

## Install 🚀
Get started on the path to effortless configuration management with these quick commands:

🔥 Add `env_reader` to your `pubspec.yaml` with a single line: 
```bash
flutter pub add env_reader
```
  
✨ Unlock the magic by activating the `env_reader` CLI:
```bash
dart pub global activate env_reader
```

## Usage 🚀
Step into the realm of effortless configuration management and elevate your development experience with these straightforward steps:

### 1. Set up your configuration
Start by crafting your `.env` file in the root directory of your project, right alongside your trusty `pubspec.yaml`.

First thing to do is making .env file in root directory of your project folder `same directory with pubspec.yaml`.
Also for suggestion add the .env in your .gitignore.
```env
API_KEY=VYIUJ7tLdJFqrBesnOJEpkbceBB5GNz0t1aYgHxK3BMxbJOc/g==
DEBUG=true
PORT=8080
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
```

### 2. Run the command
After laying down the foundation, it's time to secure your .env masterpiece. Execute this command in your terminal:
```bash
dart run env_reader --input=".env" --password="MyStrongPassword" --model="lib/src/env_model.dart" --null-safety
```
Behold as the command weaves its magic, turning your .env into a versatile asset, accessible across platforms. It's by default meticulously stored at assets/env/.env, fortifying your configuration for app empowerment.

The result? A triumphant message like this:
```bash
Building package executable... (1.3s)
Built env_reader:env_reader.
.env successfully generated into lib/src/env_model.dart 🎉
.env successfully encrypted into assets/env/.env 🚀
```

### 3. Loading your encrypted .env
Load the env_reader instance, after ensuring your WidgetsFlutterBinding is initialized:
```dart
import 'package:env_reader/env_reader.dart';

Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.load(
    source: EnvLoader.asset('assets/env/.env'),
    password: "MyStrongPassword");

  runApp(...);
}
```
### 4. Access your configuration
And now, the moment of truth—access your configuration values with ease:
```dart
import 'package:env_reader/env_reader.dart';
import 'package:my_package/src/env_model.dart';

String api = Env.read("API_KEY") ?? "Got'cha 😎";
bool debug = Env.read<bool>("DEBUG") ?? false;

Text(
  text:
    debug ? "🤫 pssst, this is my api key y'all \n\n $api" : "Nothing to see here 🤪",
  ),
);

// Or you can access the value directly from env generated model earlier

Text(
  text:
    EnvModel.debug ? "🤫 pssst, this is my api key y'all \n\n ${EnvModel.apiKey}" : "Nothing to see here 🤪",
  ),
);
```

## Env Reader Command 🚀
Available commands:

| Flag                     | Description                                                  |
|--------------------------|--------------------------------------------------------------|
| -i, --input (mandatory)  | Input path of the .env file                                 |
| -p, --password (mandatory)| Password for encryption & decryption                        |
| -o, --output              | Custom output path for the encrypted .env file              |
|                          | (defaults to "assets/env/")                                  |
| --model                  | Generate model.dart file to your desired path               |
| -h, --[no-]help          | Print usage information                                     |
| --null-safety            | Make the model null safety                                   |
| --[no-]pubspec           | Insert asset path to pubspec.yaml                           |
|                          | (defaults to on)                                             |
| --[no-]gitignore         | Insert .env input file into .gitignore                      |
|                          | (defaults to on)                                             |

Example usage:
```bash
dart run env_reader --input=".env" --password="MyStrongPassword" --model="lib/src/env_model.dart" --null-safety --no-pubspec --no-gitignore --output="assets/env/custom.env"
```


## Example 🚀

- <a href="https://github.com/Nialixus/env_reader/blob/main/example/lib/main.dart">env_reader/example/lib/main.dart</a>
