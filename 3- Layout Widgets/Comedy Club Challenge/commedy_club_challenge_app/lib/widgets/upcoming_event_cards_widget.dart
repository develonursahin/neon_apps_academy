// ignore_for_file: must_be_immutable
import 'package:commedy_club_challenge_app/models/models.dart';
import 'package:commedy_club_challenge_app/viewmodels/home_view_model.dart';
import 'package:commedy_club_challenge_app/widgets/card_slider_widget.dart';
import 'package:commedy_club_challenge_app/widgets/neon_text_widget.dart';
import 'package:flutter/material.dart';

class UpcomingEventCards extends StatelessWidget {
  final List<Event> upComingEvents;
  UpcomingEventCards({
    super.key,
    required this.upComingEvents,
  });

  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NeonTextWidget(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            text: "Upcoming Events",
            keywordColors: {
              "Upcoming": Colors.indigoAccent,
              "Events": Colors.orangeAccent
            },
            defaultColor: Colors.white),
        const SizedBox(height: 10),
        SizedBox(
          height: 360,
          child: CardSlider(
            events: upComingEvents,
            direction: Axis.horizontal,
            ticket: true,
          ),
        ),
      ],
    );
  }
}
