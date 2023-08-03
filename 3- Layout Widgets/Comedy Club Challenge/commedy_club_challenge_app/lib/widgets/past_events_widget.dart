import 'package:commedy_club_challenge_app/models/models.dart';
import 'package:commedy_club_challenge_app/widgets/card_slider_widget.dart';
import 'package:commedy_club_challenge_app/widgets/neon_text_widget.dart';
import 'package:flutter/material.dart';

class PastEvents extends StatelessWidget {
  final List<Event> pastEvents;
  const PastEvents({
    Key? key,
    required this.pastEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NeonTextWidget(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          text: "Past Events",
          keywordColors: {
            "Past": Colors.orangeAccent,
            "Events": Colors.indigoAccent,
          },
          defaultColor: Colors.white,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 360,
          child: CardSlider(
            events: pastEvents,
            direction: Axis.vertical,
            ticket: false,
          ),
        ),
      ],
    );
  }
}
