import 'dart:io';

import 'package:env_reader/env_reader.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print(File('../.env').existsSync());
  await Env.instance.load();
  runApp(const MaterialApp(title: "Env Reader", debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(Env.instance.value);
    return Scaffold(body: Center(child: Text(Env.read<String>("MY_STRING") ?? "Failed to read .env")));
  }
}
