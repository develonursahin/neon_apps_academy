import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  double val = 0;
  Color color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
      ),
      body: Container(
          margin: const EdgeInsets.all(100),
          child: Column(
            children: [
              SizedBox(
                child: Slider(
                  value: val,
                  onChanged: (value) {
                    setState(() {
                      val = value;
                      if (value == 1) {
                        color = Colors.red;
                      } else if (value == 0) {
                        color = Colors.green;
                      } else {
                        color = Color.lerp(Colors.green, Colors.red, value)!;
                      }
                    });
                  },
                  activeColor: color,
                  divisions: 10,
                  thumbColor: Colors.blue,
                ),
              )
            ],
          )),
    );
  }
}
