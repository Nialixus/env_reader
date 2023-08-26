import 'package:env_reader/env_reader.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> arguments) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load(password: "my strong password");
  runApp(const MaterialApp(title: "Env Reader", debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(Env.read<String>("MY_STRING") ?? "Oops")));
  }
}
