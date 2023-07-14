import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonScreenState createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  bool isPressed = false;
  Color buttonColor = Colors.purple;
  bool isButtonActive = false;
  bool shakeActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<String>(
            hint: const Text('Select an option'),
            items: <String>['Option 1', 'Option 2', 'Option 3']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              switch (newValue) {
                case 'Option 1':
                  break;
                case 'Option 2':
                  break;
                case 'Option 3':
                  break;
              }
            },
          ),
          InkResponse(
            onTap: () {
              setState(() {
                isPressed = !isPressed;
              });
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: isPressed
                    ? const LinearGradient(
                        colors: [Colors.red, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                image: isPressed
                    ? null
                    : const DecorationImage(
                        image: NetworkImage(
                            'https://cdn1.vogel.de/unsafe/800x0/smart/images.vogel.de/vogelonline/bdb/1286800/1286845/original.jpg'),
                        fit: BoxFit.cover,
                      ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: const Text(
                'Button',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyanAccent,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTapDown: (_) {
              setState(() {
                buttonColor = Colors.yellow;
              });
            },
            onTapCancel: () {
              setState(() {
                buttonColor = Colors.purple;
              });
            },
            onTapUp: (_) {
              setState(() {
                buttonColor = Colors.purple;
              });
            },
            child: Container(
              width: 200,
              height: 50,
              color: buttonColor,
              child: const Center(
                child: Text(
                  'Button',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isButtonActive = !isButtonActive;
              });
            },
            child: const Text('Toggle Button'),
          ),
          ElevatedButton(
            onPressed: isButtonActive
                ? null
                : () {
                    // ignore: avoid_print
                    print('Button is active!');
                  },
            child: const Text('Active Button'),
          ),
          ShakeWidget(
              duration: const Duration(milliseconds: 5),
              shakeConstant: ShakeHardConstant2(),
              autoPlay: shakeActive,
              enableWebMouseHover: true,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      shakeActive = !shakeActive;
                    });
                  },
                  child: const Text("Shake Button"))),
        ],
      ),
    );
  }
}
