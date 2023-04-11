import 'package:flutter/material.dart';
import 'package:integration_testing_demo/ui/pages/my_home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fun with Pexels',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.indigo),
        home: const MyHomePage());
  }
}
