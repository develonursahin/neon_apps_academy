import 'package:flutter/material.dart';
import 'package:ui_widgets_app/views/alert_controller_view.dart';
import 'package:ui_widgets_app/views/button_view.dart';
import 'package:ui_widgets_app/views/circular_progress_indicator_view.dart';
import 'package:ui_widgets_app/views/container_view.dart';
import 'package:ui_widgets_app/views/data_table_view.dart';
import 'package:ui_widgets_app/views/grid_view.dart';
import 'package:ui_widgets_app/views/linear_progress_indicator_view.dart';
import 'package:ui_widgets_app/views/list_view.dart';
import 'package:ui_widgets_app/views/page_control_view.dart';
import 'package:ui_widgets_app/views/picker_view.dart';
import 'package:ui_widgets_app/views/scroll_view.dart';
import 'package:ui_widgets_app/views/search_bar_view.dart';
import 'package:ui_widgets_app/views/segmented_control_view.dart';
import 'package:ui_widgets_app/views/slider_view.dart';
import 'package:ui_widgets_app/views/stack_view.dart';
import 'package:ui_widgets_app/views/stepper_view.dart';
import 'package:ui_widgets_app/views/switch_view.dart';
import 'package:ui_widgets_app/views/tab_bar_view.dart';
import 'package:ui_widgets_app/views/textfield_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  ContainerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Widgets'),
      ),
      body: GridView.builder(
        itemCount: pageNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        return const ContainerScreen();
                      case 'Buttons':
                        return const ButtonScreen();
                      case 'TextFields':
                        return const TextFieldScreen();
                      case 'Slider':
                        return const SliderScreen();
                      case 'Switch':
                        return const SwitchScreen();
                      case 'Stepper':
                        return const StepperScreen();
                      case 'PageControl':
                        return const PageControlScreen();
                      case 'Segmented Control':
                        return const SegmentedControlScreen();
                      case 'Alert Controller':
                        return const AlertControllerScreen();
                      case 'Circular Progress Indicator':
                        return const CircularProgressIndicatorScreen();
                      case 'Linear Progress Indicator':
                        return const LinearProgressIndicatorScreen();
                      case 'Stack':
                        return const StackScreen();
                      case 'Scroll View':
                        return const ScrollScreen();
                      case 'Tab Bar':
                        return const TabBarScreen();
                      case 'Picker':
                        return const PickerScreen();
                      case 'Data Table':
                        return DataTableScreen();
                      case 'Search Bar':
                        return const SearchBarScreen();
                      case 'Grid View':
                        return GridViewScreen();
                      case 'List View':
                        return ListViewScreen();
                      default:
                        return const ContainerScreen();
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    pageNames[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
