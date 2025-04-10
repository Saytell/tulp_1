import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(ProTranslatorApp());
}

class ProTranslatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), 
    );
  }
}
