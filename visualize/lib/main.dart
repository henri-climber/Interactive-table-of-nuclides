import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visualize/constants/design.dart';
import 'package:visualize/graph_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table of nuclides',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: black),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: h1,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: TextStyle(
              fontSize: h2,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            displaySmall: TextStyle(
              fontSize: h3,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            headlineLarge: TextStyle(
              fontSize: h4,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              fontSize: h5 - 2,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            headlineSmall: TextStyle(
              fontSize: h6,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontSize: h7,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            titleMedium: TextStyle(
              fontSize: h7,
              color: black,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              fontSize: paragraph,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            bodyMedium: TextStyle(
              fontSize: h7,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            bodySmall: TextStyle(
              fontSize: 11,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            labelLarge: TextStyle(
              fontSize: h5,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            labelMedium: TextStyle(
              fontSize: h6,
              color: black,
              fontWeight: FontWeight.normal,
            ),
            labelSmall: TextStyle(
              fontSize: h7,
              color: black,
              fontWeight: FontWeight.normal,
            ),
          )),
      home: const GraphScreen(),
    );
  }
}
