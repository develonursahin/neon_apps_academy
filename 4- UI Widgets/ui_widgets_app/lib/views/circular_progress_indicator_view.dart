import 'dart:async';

import 'package:flutter/material.dart';

class CircularProgressIndicatorScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CircularProgressIndicatorScreen({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _CircularProgressIndicatorScreenState createState() =>
      _CircularProgressIndicatorScreenState();
}

class _CircularProgressIndicatorScreenState
    extends State<CircularProgressIndicatorScreen> {
  bool _isLoading = false;
  int _progress = 0;

  void _startLoading() {
    setState(() {
      _isLoading = true;
      _progress = 0;
    });

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 1;
        if (_progress == 100) {
          _isLoading = false;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Progress Indicator'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isLoading ? null : _startLoading,
                child: const Text('Start Loading'),
              ),
              const SizedBox(height: 16),
              if (_isLoading)
                Column(
                  children: [
                    CircularProgressIndicator(
                      value: _progress / 100,
                    ),
                    const SizedBox(height: 16),
                    Text('Progress: $_progress%'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
