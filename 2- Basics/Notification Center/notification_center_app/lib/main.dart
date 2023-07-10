// ignore_for_file: library_private_types_in_public_api, unnecessary_late

import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Password Solvent',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DecryptScreen(),
    );
  }
}

class DecryptScreen extends StatefulWidget {
  const DecryptScreen({super.key});

  @override
  _DecryptScreenState createState() => _DecryptScreenState();
}

final random = Random();
final List<String> wordList = [
  "Python",
  "CSS",
  "dart",
  "flutter",
  "HTML",
  "C#",
  "C++",
  "Neon Apps",
  "Software",
  "Developer",
  "Designer",
  "UI/UX"
];

final randomIndex = random.nextInt(wordList.length);
final randomWord = wordList[randomIndex];
String decryptedMessage = encryptMessage(randomWord);
late String encryptedMessage = randomWord;

class _DecryptScreenState extends State<DecryptScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encrypted Message Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Encrypted Message: $decryptedMessage",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter the encrypted message',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String input = _textEditingController.text;
                if (input == decryptedMessage) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CountdownScreen(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(''),
                      content: const Text('Please enter the correct message.'),
                      actions: [
                        TextButton(
                          child: const Text('Okay'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Solve the password'),
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int countdownSeconds = 15;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdownSeconds--;
      });

      if (countdownSeconds == 0) {
        timer.cancel();
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              icon: const Icon(
                Icons.lock_open,
                color: Colors.green,
                size: 100,
              ),
              title: const Text('The password is solved!'),
              content: Text("Encrypted Message: $encryptedMessage"),
            );
          },
        ).then((value) {
          Navigator.pop(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encrypted Message Application'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock,
              size: 200,
              color: Colors.red,
            ),
            CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              strokeWidth: 10,
              value: countdownSeconds / 15,
            ),
            const SizedBox(height: 16),
            Text(
              '$countdownSeconds',
              style: const TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}

String encryptMessage(String message) {
  String encryptedMessage = '';
  for (int i = 0; i < message.length; i++) {
    int charCode = message.codeUnitAt(i);
    charCode++;
    encryptedMessage += String.fromCharCode(charCode);
  }
  return encryptedMessage;
}

String decryptMessage(String encryptedMessage) {
  String decryptedMessage = '';
  for (int i = 0; i < encryptedMessage.length; i++) {
    int charCode = encryptedMessage.codeUnitAt(i);
    charCode--;
    decryptedMessage += String.fromCharCode(charCode);
  }
  return decryptedMessage;
}
