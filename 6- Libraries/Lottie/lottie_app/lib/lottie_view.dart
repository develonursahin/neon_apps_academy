import 'dart:async';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieView extends StatefulWidget {
  const LottieView({super.key});

  @override
  State<LottieView> createState() => _LottieViewState();
}

class _LottieViewState extends State<LottieView> {
  double percentage = 0.0;

  bool isProcessing = false;

  bool isCompleted = false;

  final GlobalKey _repaintBoundaryKey = GlobalKey();

  Future<void> startSharpeningProcess() async {
    while (percentage <= 99.9) {
      setState(() {
        percentage += 0.1;
      });
      if (!isProcessing) {
        return;
      }
      await Future.delayed(const Duration(microseconds: 1));
    }
    setState(() {
      isProcessing = false;
    });
    if (percentage.toInt() == 99) {
      setState(() {
        isCompleted = true;
      });
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  void stopSharpeningProcess() {
    setState(() {
      isProcessing = false;
    });
  }

  void resetProcess() {
    setState(() {
      percentage = 0.0;
      isCompleted = false;
    });
  }

  Widget buildCompletedWidget() {
    return RepaintBoundary(
      key: _repaintBoundaryKey,
      child: Lottie.asset(
        'assets/completed.json',
        width: 200,
        height: 200,
        animate: isCompleted,
        onLoaded: (composition) {
          if (percentage.toInt() == 99) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Image.network(
                      "https://picsum.photos/1000/1000",
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildProcessingWidget() {
    if (percentage == 0) {
      return Blur(
        blur: 5,
        child: Image.network(
          "https://picsum.photos/1000/1000",
        ),
      );
    } else {
      return Lottie.asset(
        'assets/loading_animation.json',
        width: 200,
        height: 200,
        animate: isProcessing,
        onLoaded: (composition) async {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fotoğraf Keskinleştirme"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isCompleted ? buildCompletedWidget() : buildProcessingWidget(),
            const SizedBox(height: 20),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            isCompleted
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isProcessing = !isProcessing;
                      });
                      await startSharpeningProcess();
                    },
                    child:
                        Text(isProcessing ? "İşlemi Durdur" : "Keskinleştir"),
                  ),
            !isCompleted
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: resetProcess,
                    child: const Text("Reset"),
                  ),
          ],
        ),
      ),
    );
  }
}
