import 'package:flutter/material.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll View Rescue'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    Color color;
                    if (index % 2 == 0) {
                      color = Colors.blue;
                    } else {
                      color = Colors.green;
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      color: color,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          'Spell ${index + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
