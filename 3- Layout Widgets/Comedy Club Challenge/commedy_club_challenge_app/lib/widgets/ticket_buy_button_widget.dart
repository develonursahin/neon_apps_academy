import 'package:commedy_club_challenge_app/models/models.dart';
import 'package:commedy_club_challenge_app/widgets/neon_text_widget.dart';
import 'package:flutter/material.dart';

class TicketBuyButton extends StatelessWidget {
  final List<Ticket> tickets;
  final String eventName;

  const TicketBuyButton({
    Key? key,
    required this.tickets,
    required this.eventName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          constraints: const BoxConstraints(minHeight: 120, maxHeight: 180),
          barrierColor: Colors.amber,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(eventName,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(tickets[index].ticketName!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(flex: 1),
                                  Text(tickets[index].ticketPrice!.toString(),
                                      style: const TextStyle(fontSize: 18)),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.cyan, width: 2),
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_seat,
            color: Colors.green,
          ),
          SizedBox(width: 10.0),
          NeonTextWidget(
            fontSize: 15,
            fontWeight: FontWeight.w100,
            text: "Buy Ticket",
            keywordColors: {
              "Buy": Colors.orangeAccent,
              "Ticket": Colors.indigoAccent
            },
            defaultColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
