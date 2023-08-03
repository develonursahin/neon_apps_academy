import 'package:expanded_padding_app/views/discovery_screen_view/discovery_view.dart';
import 'package:expanded_padding_app/views/hotel_reservation_view/hotel_reservation_view.dart';
import 'package:expanded_padding_app/views/route_planning_view/route_planning_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TravelEaseApp());
}

class TravelEaseApp extends StatelessWidget {
  const TravelEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<ButtonInfo> buttons = [
    ButtonInfo(
      icon: Icons.explore,
      label: 'Discover',
      color: Colors.blue,
      route: DiscoveryPage(),
    ),
    ButtonInfo(
      icon: Icons.map,
      label: 'Route Planning',
      color: Colors.orange,
      route: const RoutePlanningPage(),
    ),
    ButtonInfo(
      icon: Icons.hotel,
      label: 'Hotel Reservation',
      color: Colors.green,
      route: const HotelReservationPage(),
    ),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TravelEase'),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    buttons[index].icon,
                    size: 40,
                    color: buttons[index].color,
                  ),
                  title: Text(
                    buttons[index].label,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => buttons[index].route),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonInfo {
  final IconData icon;
  final String label;
  final Color color;
  final Widget route;

  ButtonInfo({
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });
}
