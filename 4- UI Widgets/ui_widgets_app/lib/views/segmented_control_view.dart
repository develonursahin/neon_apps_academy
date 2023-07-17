import 'package:flutter/material.dart';

class SegmentedControlScreen extends StatefulWidget {
  SegmentedControlScreen();

  @override
  _SegmentedControlScreenState createState() => _SegmentedControlScreenState();
}

class _SegmentedControlScreenState extends State<SegmentedControlScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segmented Control'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SegmentedControl(
              children: {
                0: Text('Flutter Development Team'),
                1: Text('Android Development Team'),
                2: Text('iOS Development Team'),
              },
              onValueChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              groupValue: _selectedIndex,
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: _selectedIndex == 0 ? 200 : 100,
              color: _selectedIndex == 0 ? Colors.green : Colors.blue,
              alignment: Alignment.center,
              child: Text(
                _selectedIndex == 0
                    ? 'Flutter Development Team'
                    : _selectedIndex == 1
                        ? 'Android Development Team'
                        : 'iOS Development Team',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentedControl extends StatelessWidget {
  final Map<int, Widget> children;
  final ValueChanged<int> onValueChanged;
  final int groupValue;

  SegmentedControl({
    required this.children,
    required this.onValueChanged,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: children.entries
            .map(
              (entry) => Expanded(
                child: GestureDetector(
                  onTap: () => onValueChanged(entry.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          groupValue == entry.key ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: entry.value,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
