import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const BarbieAndKenApp());
}

class BarbieAndKenApp extends StatefulWidget {
  const BarbieAndKenApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BarbieAndKenAppState createState() => _BarbieAndKenAppState();
}

class _BarbieAndKenAppState extends State<BarbieAndKenApp> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        return decodedData;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Barbie & Ken"),
          backgroundColor: Colors.pink,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error fetching data"),
              );
            } else {
              final apiData = snapshot.data;
              return ListView.builder(
                itemCount: apiData!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text(apiData[index]['title']),
                    trailing: Image.network(
                      apiData[index]['thumbnailUrl'] ??
                          'https://upload.wikimedia.org/wikipedia/commons/b/b1/Loading_icon.gif?20151024034921',
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
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
