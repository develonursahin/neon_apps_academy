import 'package:flutter/material.dart';

class AlertControllerScreen extends StatelessWidget {
  const AlertControllerScreen({Key? key});

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
                    return AlertDialog(
                      title: const Text('No Buttons Alert'),
                      content: const Text('This alert has no buttons.'),
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
                            print('Button 1 clicked');
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
                            print('Button 1 clicked');
                          },
                          child: const Text('Button 1'),
                        ),
                        TextButton(
                          onPressed: () {
                            print('Button 2 clicked');
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
                            print('Entered text: ${textFieldController.text}');
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
                  position: RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    PopupMenuItem(
                      child: const Text('Option 1'),
                      value: 'Option 1',
                    ),
                    PopupMenuItem(
                      child: const Text('Option 2'),
                      value: 'Option 2',
                    ),
                    PopupMenuItem(
                      child: const Text('Option 3'),
                      value: 'Option 3',
                    ),
                  ],
                  elevation: 8,
                ).then((value) {
                  if (value != null) {
                    print('Selected option: $value');
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
                    return Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Activity Controller'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              print('Share File selected');
                              Navigator.pop(context);
                            },
                            child: const Text('Share File'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Share Image selected');
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
