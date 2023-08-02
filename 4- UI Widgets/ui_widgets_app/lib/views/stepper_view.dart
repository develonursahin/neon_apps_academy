import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StepperScreenState createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Doll\'s Dress Up Stepper'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Value: $currentValue',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 11,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Card(
                      child: ListTile(
                        title: Text('Outfit ${index + 1}'),
                        tileColor: currentValue ~/ 5 == index
                            ? Colors.blue
                            : Colors.white,
                        leading: Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .primaries[(index + 1) % Colors.primaries.length],
                          child: const Icon(Icons.checkroom_outlined),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentValue = (currentValue - 5).clamp(0, 50);
                    });
                  },
                  child: const Text('Previous'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentValue = (currentValue + 5).clamp(0, 50);
                    });
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
