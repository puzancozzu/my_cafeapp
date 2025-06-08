import 'package:cafe_app/ui/login_page_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe 90\'s',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        dividerColor: Colors.transparent,
      ),
    builder: (context, child) {
      return SafeArea(child: child ?? const SizedBox.shrink());
    },
      home: const LoginPageUi(),
    );
  }
}

