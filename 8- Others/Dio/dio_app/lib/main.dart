import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      Response response = await Dio().get(
        'https://jsonplaceholder.typicode.com/users',
        options: Options(headers: {'cache-control': 'no-cache'}),
      );
      setState(() {
        users = response.data;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
    }
  }

  Future<void> postData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var data = {
        "title": "Sample Title",
        "body": "This is a sample post body.",
        "userId": 1,
      };
      Response response = await Dio()
          .post('https://jsonplaceholder.typicode.com/posts', data: data);
      if (kDebugMode) {
        print('Post işlemi başarılı! Yanıt: ${response.data}');
        String message = "Post işlemi başarılı! Yanıt: ${response.data}";
        returnMessage(message);
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void returnMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio ile Flutter Ağ İşlemleri'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: postData,
        child: const Icon(Icons.send),
      ),
    );
  }
}
