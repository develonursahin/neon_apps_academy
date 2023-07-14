import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContainerGrid(),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final List<String> pageNames = [
    'Container',
    'Buttons',
    'TextField',
    'Slider',
    'Switch',
    'Stepper',
    'PageControl',
    'Segmented Control',
    'Alert Controller',
    'Circular Progress Indicator',
    'Linear Progress Indicator',
    'Stack',
    'Scroll View',
    'Tab Bar',
    'Picker',
    'Data Table',
    'Search Bar',
    'Grid View',
    'List View',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UI Widgets'),
      ),
      body: GridView.builder(
        itemCount: pageNames.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDetail(pageName: pageNames[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.white),
              ),
              child: Center(
                child: Text(
                  pageNames[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageDetail extends StatelessWidget {
  final String pageName;

  PageDetail({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Center(
        child: Text(
          pageName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
