import 'package:commedy_club_challenge_app/models/models.dart';
import 'package:commedy_club_challenge_app/widgets/events_card_widget.dart';
import 'package:commedy_club_challenge_app/widgets/ticket_buy_button_widget.dart';
import 'package:flutter/material.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({
    super.key,
    required this.events,
    required this.ticket,
    required this.direction,
  });

  final List<Event> events;
  final bool ticket;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: direction,
      itemCount: events.length,
      itemBuilder: (context, index) {
        var event = events[index];
        return Container(
          decoration: BoxDecoration(
              color: Colors.purpleAccent,
              boxShadow: const [
                BoxShadow(color: Colors.purple, blurRadius: 20, spreadRadius: 2)
              ],
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              EventsCard(imageUrl: event.eventImageUrl!),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName!,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 30)
                          ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.cyanAccent),
                              borderRadius: BorderRadius.circular(16)),
                          width: 100,
                          height: 35,
                          child: Text(
                              "${event.dateTime!.day}.${event.dateTime!.month}.${event.dateTime!.year}"),
                        ),
                        Visibility(
                            visible: ticket,
                            child: TicketBuyButton(
                              tickets: event.tickets!,
                              eventName: event.eventName!,
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
