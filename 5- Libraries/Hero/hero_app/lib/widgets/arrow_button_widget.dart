import 'package:flutter/material.dart';
import 'package:hero_app/game_over_view.dart';

class ArrowButtonInfo {
  final IconData iconData;
  final bool isEnabled;

  ArrowButtonInfo(this.iconData, this.isEnabled);
}

bool? status = true;
final List<ArrowButtonInfo> icons = [
  ArrowButtonInfo(Icons.arrow_upward, status!),
  ArrowButtonInfo(Icons.arrow_back, status!),
  ArrowButtonInfo(Icons.arrow_downward, status!),
  ArrowButtonInfo(Icons.arrow_forward, status!),
];

int falseCount = 3;

class ArrowButtons extends StatelessWidget {
  const ArrowButtons({
    Key? key,
    required this.heartStates,
    required this.enabledArrowButton,
    required this.onArrowPressed,
  }) : super(key: key);

  final List<bool> heartStates;
  final String enabledArrowButton;
  final Function(String) onArrowPressed;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(60, 60),
              ),
              onPressed: icons[0].isEnabled
                  ? () {
                      if (enabledArrowButton == 'Up') {
                        onArrowPressed('Up');
                      } else {
                        _showAlertDialog(context);
                      }
                    }
                  : () => _showAlertDialog(context),
              child: Icon(
                icons[0].iconData,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[1].isEnabled &&
                          icons[1].iconData == Icons.arrow_back &&
                          enabledArrowButton == 'Left'
                      ? () => onArrowPressed('Left')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[1].iconData,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[2].isEnabled &&
                          icons[2].iconData == Icons.arrow_downward &&
                          enabledArrowButton == 'Down'
                      ? () => onArrowPressed('Down')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[2].iconData,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(60, 60),
                  ),
                  onPressed: icons[3].isEnabled &&
                          icons[3].iconData == Icons.arrow_forward &&
                          enabledArrowButton == 'Right'
                      ? () => onArrowPressed('Right')
                      : () => _showAlertDialog(context),
                  child: Icon(
                    icons[3].iconData,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong direction'),
          content: Text('Remaining Life: ${falseCount - 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                falseCount--;
                if (falseCount == 0) {
                  // Navigate to the Game Over View
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameOverView(),
                    ),
                  );
                  falseCount = 3;
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
