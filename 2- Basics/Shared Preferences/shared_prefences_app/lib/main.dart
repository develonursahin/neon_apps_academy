// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class Destination {
  String name;
  bool hasVisited;
  int? visitCount;
  double rating;

  Destination(this.name, this.hasVisited, {this.visitCount, this.rating = 0.0});

  Destination.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        hasVisited = json['hasVisited'],
        visitCount = json['visitCount'],
        rating = json['rating'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hasVisited': hasVisited,
      'visitCount': visitCount,
      'rating': rating,
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places to Visit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DestinationListScreen(),
    );
  }
}

class DestinationListScreen extends StatefulWidget {
  const DestinationListScreen({super.key});

  @override
  _DestinationListScreenState createState() => _DestinationListScreenState();
}

class _DestinationListScreenState extends State<DestinationListScreen> {
  List<Destination> _destinations = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _visitCountController = TextEditingController();
  bool _hasVisited = false;
  bool _isAddingDestination = false;
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve saved destinations from SharedPreferences
    List<String>? destinationsJson = prefs.getStringList('destinations');
    if (destinationsJson != null) {
      setState(() {
        _destinations = destinationsJson
            .map((json) => Destination.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  Future<void> saveDestinations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save destinations to SharedPreferences
    List<String> destinationsJson = _destinations
        .map((destination) => jsonEncode(destination.toJson()))
        .toList();
    await prefs.setStringList('destinations', destinationsJson);
    if (kDebugMode) {
      print("object");
    }
  }

  void addDestination() {
    String name = _nameController.text;

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter a destination name.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_hasVisited) {
      String visitCountText = _visitCountController.text;
      if (visitCountText.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Please enter a visit count.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      int? visitCount = int.tryParse(visitCountText);
      if (visitCount == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text('Please enter a valid visit count.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      _destinations.add(
          Destination(name, true, visitCount: visitCount, rating: _rating));
    } else {
      _destinations.add(Destination(name, false, rating: _rating));
    }

    saveDestinations();

    _nameController.clear();
    _visitCountController.clear();
    _hasVisited = false;
    _rating = 0.0;

    setState(() {});
  }

  void deleteDestination(int index) {
    _destinations.removeAt(index);
    saveDestinations();
    setState(() {});
  }

  void openAddDestination() {
    setState(() {
      _isAddingDestination = true;
    });
  }

  void closeAddDestination() {
    setState(() {
      _isAddingDestination = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Destinations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _destinations.length,
              itemBuilder: (BuildContext context, int index) {
                Destination destination = _destinations[index];
                return Dismissible(
                  key: Key(destination.name),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    deleteDestination(index);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(16.0),
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(destination.name),
                      subtitle: Text(
                        'Visited: ${destination.hasVisited ? 'Yes' : 'No'} (${destination.visitCount ?? 0} times)',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (i) => Icon(
                            i < destination.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isAddingDestination)
            Card(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Destination Name',
                      ),
                    ),
                    CheckboxListTile(
                      value: _hasVisited,
                      onChanged: (value) {
                        setState(() {
                          _hasVisited = value ?? false;
                        });
                      },
                      title: const Text('Have you visited this place before?'),
                    ),
                    if (_hasVisited)
                      Column(
                        children: [
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: _visitCountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Visit Count',
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: _rating,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 25.0,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: addDestination,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: closeAddDestination,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (!_isAddingDestination)
            Card(
              child: ListTile(
                title: const Text('Add New Destination'),
                trailing: const Icon(Icons.add),
                onTap: openAddDestination,
              ),
            ),
        ],
      ),
    );
  }
}
