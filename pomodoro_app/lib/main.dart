import 'package:flutter/material.dart';
import 'package:pomodoro_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFF74b9ff),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFdfe6e9),
          ),
          bodyMedium: TextStyle(
            color: Color(0xFFdfe6e9),
          ),
        ),
        cardColor: const Color(0xFFdfe6e9),
      ),
      home: const HomeScreen(),
    );
  }
}
