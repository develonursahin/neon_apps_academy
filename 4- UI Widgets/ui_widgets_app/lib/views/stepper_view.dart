import 'package:flutter/material.dart';

class StepperScreen extends StatefulWidget {
  StepperScreen({Key? key}) : super(key: key);

  @override
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
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 11,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
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
                          child: Icon(Icons.checkroom_outlined),
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
                  child: Text('Previous'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentValue = (currentValue + 5).clamp(0, 50);
                    });
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
