import 'package:flutter/material.dart';
import 'package:travel_ease_app/views/discovery_screen_view/detail_view.dart';

class DiscoveryPage extends StatelessWidget {
  final List<Destination> destinations = [
    Destination(
      title: 'Paris',
      description: 'Paris is the capital and most populous city of France.',
    ),
    Destination(
      title: 'Rome',
      description: 'Rome is the capital city and a special comune of Italy.',
    ),
    Destination(
      title: 'New York',
      description:
          'New York City is the most populous city in the United States.',
    ),
    Destination(
      title: 'London',
      description:
          'London is the capital and largest city of England and the United Kingdom.',
    ),
    Destination(
      title: 'Berlin',
      description: 'Berlin is the capital and largest city of Germany.',
    ),
    Destination(
      title: 'Istanbul',
      description:
          'Istanbul is the largest city in Turkey and straddles Europe and Asia across the Bosphorus Strait.',
    ),
    Destination(
      title: 'Izmir',
      description:
          'Izmir is a metropolitan city in the western extremity of Anatolia, Turkey.',
    ),
    Destination(
      title: 'Sivas',
      description:
          'Sivas is a city in central Turkey and the seat of Sivas Province.',
    ),
    Destination(
      title: 'Malatya',
      description:
          'Malatya is a city in eastern Turkey and a major center for apricot production.',
    ),
  ];

   DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final destination = destinations[index];
          final imagePath =
              'assets/images/${destination.title.toLowerCase()}.jpg';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(destination: destination),
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      destination.title,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Destination {
  final String title;
  final String description;

  Destination({required this.title, required this.description});
}
