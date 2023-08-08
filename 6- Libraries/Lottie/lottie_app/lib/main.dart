import 'package:flutter/material.dart';
import 'lottie_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottie View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LottieView(),
    );
  }
}
