<p align="center">
  <img src='https://user-images.githubusercontent.com/45191605/274121951-21239cc4-37b3-4dd2-864f-d5f528da4e22.png' width=200 height=200/>
  <br>
  <a href='https://pub.dev/packages/env_reader'><img src='https://img.shields.io/pub/v/env_reader.svg?logo=flutter&color=blue&style=flat-square'/></a>
</p>

# Env Reader
Read, encrypt, or generate environment variables from .env file into an obfuscated Dart model.

## Features 🚀
- **Automated Generation:** Transform your .env files into dynamic Dart models directly. No need to add annotation. ✨
- **Seamless Integration:** Directly update your pubspec.yaml and .gitignore on command. No need manual labor. 🛠️ 
- **Fortified Encryption:** Shield your precious .env configurations with an encryption. Say no to prying eyes.🔒  
- **Data Diversity Unleashed:** Whether they're integers, decimals, booleans, or strings. Automatic interpretation is at your service. 🎮
- **Versatile Sourcing**: Load your .env from various sources: assets, files, memory, network, and strings. The choice is yours. 🔄

## Install 🚀
Get started with these quick commands:

🔥 Add `env_reader` to your `pubspec.yaml` with a single line: 
```bash
dart pub add env_reader
```
  
✨ Unlock the magic by activating the `env_reader` CLI:
```bash
dart pub global activate env_reader
```

## Usage 🚀
Now elevate your development experience with these straightforward steps:

### 1. Set up your configuration
Start by crafting your `.env` file in the root directory of your project, right alongside your trusty `pubspec.yaml`.
```env
API_KEY=VYIUJ7tLdJFqrBesnOJEpkbceBB5GNz0t1aYgHxK3BMxbJOc/g==
DEBUG=true
PORT=8080
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
```

### 2. Run the command (Optional)
Now, if you want to generate encrypted env file, run this command in your terminal:
```bash
dart run env_reader --input=".env" --output="assets/env/" --key="MyOptionalSecretKey"
```
> [!NOTE]
> **`output:`** .env successfully encrypted into assets/env/.env 🚀

also if you want to generate dart model from this env file, use tihs:
```bash
dart run env_reader --input-".env" --model="lib/src/env_model.dart" --null-safety
```
> [!NOTE]
> **`output:`** .env successfully generated into lib/src/env_model.dart 🎉

### 3. Loading your .env
Load the env_reader instance:
```dart
import 'package:env_reader/env_reader.dart';
// If you want to use env_reader for dart projects only, call this instead ↓↓
import 'package:env_reader/env_reader_core.dart';

await Env.load(
  EnvAssetLoader('assets/env/.env'),
  "MyOptionalSecretKey");

// Or you can load by creating your own `EnvReader` instance.

EnvReader production = EnvReader();
await production.load(
  EnvAssetLoader(asset),
  "MyOptionalSecretKey");
```

### 4. Access your configuration
To get and read the value of your env:
```dart
import 'package:env_reader/env_reader.dart'; // for flutter project
import 'package:env_reader/env_reader_core.dart'; // for dart project
import 'package:my_package/src/env_model.dart';

String api = Env.read("API_KEY") ?? "Got'cha 😎";
bool debug = Env.read<bool>("DEBUG") ?? false;

// If you make your own instance, call it like this

String api = production.read("API_KEY") ?? "Got'cha 😎";
bool debug = production.read<bool>("DEBUG") ?? false;

Text(
  text:
    debug ? "🤫 pssst, this is my api key y'all \n\n $api" : "Nothing to see here 🤪",
);

// Or you can access the value directly from env generated model earlier

Text(
  text:
    EnvModel.debug ? "🤫 pssst, this is my api key y'all \n\n ${EnvModel.apiKey}" : "Nothing to see here 🤪",
);
```

## Env Reader Command 🚀
Available commands:

| Flag                     | Description                                                  |
|--------------------------|--------------------------------------------------------------|
| -i, --input (mandatory)  | Input path of the .env file                                  |
| -o, --output             | Output path for the encrypted .env file                      |
| -s, --key                | Secrey key for encryption & decryption                       |
| --model                  | Generate dart model file to your desired file path           |
| --null-safety            | Make the model null safety                                   |
| --[no-]obfuscate         | Obfuscating generated values of model                        |
|                          | (defaults to on)                                             |
| --sdk                    | Choose between generating model for flutter or dart project  |
|                          | [dart, flutter (default)]                                    |
| --[no-]pubspec           | Insert asset path to pubspec.yaml                            |
|                          | (defaults to on)                                             |
| --[no-]gitignore         | Insert .env input & output file into .gitignore              |
|                          | (defaults to on)                                             |
| -h, --help               | Print usage information                                      |

Example usage:
```bash
dart run env_reader -i ".env" -o "assets/env/" -s "MyOptionalSecretKey" --model="lib/src/env_model.dart" --null-safety --sdk flutter
```


## Example 🚀

- <a href="https://github.com/Nialixus/env_reader/blob/main/example/lib/main.dart">env_reader/example/lib/main.dart</a>
