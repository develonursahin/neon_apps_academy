import 'package:commedy_club_challenge_app/models/models.dart';
import 'package:commedy_club_challenge_app/viewmodels/home_view_model.dart';
import 'package:commedy_club_challenge_app/widgets/neon_text_widget.dart';
import 'package:commedy_club_challenge_app/widgets/past_events_widget.dart';
import 'package:commedy_club_challenge_app/widgets/upcoming_event_cards_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ComedyClub());
}

class ComedyClub extends StatelessWidget {
  const ComedyClub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comdey Club',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Comedy Club'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeViewModel vM = HomeViewModel();

  @override
  void initState() {
    super.initState();

    upComingEventsFinder();
  }

  List<Event> upComingEvents = [];
  List<Event> pastEvents = [];
  void upComingEventsFinder() {
    for (int i = 0; i < vM.events.length; i++) {
      DateTime now = DateTime.now();
      var after = vM.events[i].dateTime!.isAfter(now);
      if (kDebugMode) {
        print(after);
      }

      if (after) {
        setState(() {
          upComingEvents.add(vM.events[i]);
        });
      } else {
        setState(() {
          pastEvents.add(vM.events[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // viewModel.texts;
    return Scaffold(
      appBar: AppBar(
        title: NeonTextWidget(
          text: widget.title,
          keywordColors: const {
            'Comedy': Colors.cyanAccent,
            'Club': Colors.purpleAccent,
          },
          defaultColor: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UpcomingEventCards(
                upComingEvents: upComingEvents,
              ),
              PastEvents(pastEvents: pastEvents)
            ],
          ),
        ),
      ),
    );
  }
}
