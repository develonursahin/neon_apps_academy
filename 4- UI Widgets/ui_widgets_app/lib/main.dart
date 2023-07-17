import 'package:flutter/material.dart';
import 'package:ui_widgets_app/views/alert_controller_view.dart';
import 'package:ui_widgets_app/views/button_view.dart';
import 'package:ui_widgets_app/views/circular_progress_indicator_view.dart';
import 'package:ui_widgets_app/views/container_view.dart';
import 'package:ui_widgets_app/views/page_control_view.dart';
import 'package:ui_widgets_app/views/segmented_control_view.dart';
import 'package:ui_widgets_app/views/slider_view.dart';
import 'package:ui_widgets_app/views/stepper_view.dart';
import 'package:ui_widgets_app/views/switch_view.dart';
import 'package:ui_widgets_app/views/textfield_view.dart';

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
    'TextFields',
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
                  builder: (context) {
                    switch (pageNames[index]) {
                      case 'Container':
                        return ContainerScreen();
                      case 'Buttons':
                        return ButtonScreen();
                      case 'TextFields':
                        return TextFieldScreen();
                      case 'Slider':
                        return SliderScreen();
                      case 'Switch':
                        return SwitchScreen();
                      case 'Stepper':
                        return StepperScreen();
                      case 'PageControl':
                        return PageControlScreen();
                      case 'Segmented Control':
                        return SegmentedControlScreen();
                      case 'Alert Controller':
                        return AlertControllerScreen();
                      case 'Circular Progress Indicator':
                        return CircularProgressIndicatorScreen();
                      default:
                        return ContainerScreen();
                    }
                  },
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
