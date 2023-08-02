import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlertControllerScreen extends StatelessWidget {
  const AlertControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Controller'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('No Buttons Alert'),
                      content: Text('This alert has no buttons.'),
                    );
                  },
                );
              },
              child: const Text('No Buttons Alert'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('One Button Alert'),
                      content: const Text('This alert has one button.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Button 1 clicked');
                            }
                          },
                          child: const Text('Button 1'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('One Button Alert'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Two Buttons Alert'),
                      content: const Text('This alert has two buttons.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Button 1 clicked');
                            }
                          },
                          child: const Text('Button 1'),
                        ),
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Button 2 clicked');
                            }
                          },
                          child: const Text('Button 2'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Two Buttons Alert'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController textFieldController =
                        TextEditingController();
                    return AlertDialog(
                      title: const Text('Text Field Alert'),
                      content: TextField(
                        controller: textFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Enter some text',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print(
                                  'Entered text: ${textFieldController.text}');
                            }
                          },
                          child: const Text('Print Text'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Text Field Alert'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showMenu(
                  context: context,
                  position: const RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    const PopupMenuItem(
                      value: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    const PopupMenuItem(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                    const PopupMenuItem(
                      value: 'Option 3',
                      child: Text('Option 3'),
                    ),
                  ],
                  elevation: 8,
                ).then((value) {
                  if (value != null) {
                    if (kDebugMode) {
                      print('Selected option: $value');
                    }
                  }
                });
              },
              child: const Text('Action Sheet'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Activity Controller'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (kDebugMode) {
                                print('Share File selected');
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Share File'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (kDebugMode) {
                                print('Share Image selected');
                              }
                              Navigator.pop(context);
                            },
                            child: const Text('Share Image'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Activity Controller'),
            ),
          ],
        ),
      ),
    );
  }
}
