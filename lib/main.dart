import 'package:flutter/material.dart';

void main() {
  runApp(const SAMSDashboard());
}

class SAMSDashboard extends StatelessWidget {
  const SAMSDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
