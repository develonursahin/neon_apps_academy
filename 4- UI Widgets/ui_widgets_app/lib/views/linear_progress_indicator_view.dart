import 'package:flutter/material.dart';

class LinearProgressIndicatorScreen extends StatefulWidget {
  const LinearProgressIndicatorScreen({Key? key});

  @override
  _LinearProgressIndicatorScreenState createState() =>
      _LinearProgressIndicatorScreenState();
}

class _LinearProgressIndicatorScreenState
    extends State<LinearProgressIndicatorScreen> {
  int _progress = 0;

  void _incrementProgress() {
    setState(() {
      _progress = (_progress + 1) % 11;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Progress Indicator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _incrementProgress,
              child: const Text('Complete Task'),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _progress / 10,
              color: Colors.blue,
              backgroundColor: Colors.black,
            ),
            const SizedBox(height: 16),
            Text(
              'Progress: $_progress / 10',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
