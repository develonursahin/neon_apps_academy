import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empty'),
      ),
      body: Container(
        margin: const EdgeInsets.all(100),
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
