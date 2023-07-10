
import 'package:expanded_padding_app/views/discovery_screen_view/discovery_view.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Destination destination;

  DetailPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/${destination.title.toLowerCase()}.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  destination.description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
