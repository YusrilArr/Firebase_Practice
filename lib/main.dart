import 'package:flutter/material.dart';
import 'package:networking_firebase/adddata.dart';
import 'package:networking_firebase/networking_https.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      routes: {
        '/adddata': (context) => AddData(),
        '/home': (context) => NetworkingHttps(),
      },
      home: NetworkingHttps(),
    );
  }
}
