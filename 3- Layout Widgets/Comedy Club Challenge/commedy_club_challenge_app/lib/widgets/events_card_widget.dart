import 'package:flutter/material.dart';

class EventsCard extends StatelessWidget {
  final String imageUrl;
  const EventsCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 200,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.cyan, blurRadius: 10, spreadRadius: 2)
              ],
              border: Border.all(
                color: Colors.cyanAccent,
                width: 5,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imageUrl,
                ),
              )),
        ));
  }
}
