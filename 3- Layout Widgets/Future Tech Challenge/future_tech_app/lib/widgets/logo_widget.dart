import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.shade700,
            blurStyle: BlurStyle.outer,
            blurRadius: 30,
          ),
        ],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50)),
      ),
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
