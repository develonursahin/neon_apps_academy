import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSwitched ? Colors.lightGreen : Colors.redAccent;
    Color switchColor = isSwitched ? Colors.red : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch'),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              thumbColor: const MaterialStatePropertyAll(Colors.black),
              activeColor: switchColor,
              trackColor: MaterialStatePropertyAll(switchColor),
            ),
          ],
        ),
      ),
    );
  }
}
