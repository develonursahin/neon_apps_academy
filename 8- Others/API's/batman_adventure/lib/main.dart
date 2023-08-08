import 'package:batman_adventure/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const BatmanAdventureApp());
}

ApiModel apiModel = ApiModel();

class BatmanAdventureApp extends StatefulWidget {
  const BatmanAdventureApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BatmanAdventureAppState createState() => _BatmanAdventureAppState();
}

class _BatmanAdventureAppState extends State<BatmanAdventureApp> {
  Future<List<dynamic>>? _apiData;

  @override
  void initState() {
    super.initState();
    _apiData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiModel.api));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      return decodedData['results'];
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Batman Adventure",
            style: TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: FutureBuilder<List<dynamic>>(
          future: _apiData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final apiData = snapshot.data;
              return ListView.builder(
                itemCount: apiData?.length ?? 0,
                itemBuilder: (context, index) {
                  final character = apiData![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16.0)),
                            child: Image.network(
                              character['image']['url'],
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Powerstats",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    "Intelligence: ${character['powerstats']['intelligence']}"),
                                Text(
                                    "Strength: ${character['powerstats']['strength']}"),
                                Text(
                                    "Speed: ${character['powerstats']['speed']}"),
                                Text(
                                    "Durability: ${character['powerstats']['durability']}"),
                                Text(
                                    "Power: ${character['powerstats']['power']}"),
                                Text(
                                    "Combat: ${character['powerstats']['combat']}"),
                                const SizedBox(height: 10),
                                const Text(
                                  "Biography",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                    "Full Name: ${character['biography']['full-name']}"),
                                Text(
                                    "Alter Egos: ${character['biography']['alter-egos']}"),
                                Text(
                                    "Aliases: ${character['biography']['aliases'].join(', ')}"),
                                Text(
                                    "Place of Birth: ${character['biography']['place-of-birth']}"),
                                Text(
                                    "First Appearance: ${character['biography']['first-appearance']}"),
                                Text(
                                    "Publisher: ${character['biography']['publisher']}"),
                                Text(
                                    "Alignment: ${character['biography']['alignment']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
