import 'package:flutter/material.dart';
import 'package:thor_and_asgard/dp_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String surname = '';
  int age = 0;
  String email = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    ageController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> refreshTable() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Young Heroes of Neon Academy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => name = value!,
                  ),
                  TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(labelText: 'Surname'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your surname';
                      }
                      return null;
                    },
                    onSaved: (value) => surname = value!,
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                    onSaved: (value) => age = int.parse(value!),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Map<String, dynamic> info = {
                          'name': name,
                          'surname': surname,
                          'age': age,
                          'email': email,
                        };
                        await dbHelper.saveAsgardInfo(info);

                        // Clear text fields after saving
                        nameController.clear();
                        surnameController.clear();
                        ageController.clear();
                        emailController.clear();

                        _showSavedDialog();

                        // Refresh the table after saving
                        await refreshTable();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 200,
                ),
                child: RefreshIndicator(
                  onRefresh: refreshTable,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: dbHelper.getAllAsgardInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Name')),
                                      DataColumn(label: Text('Surname')),
                                      DataColumn(label: Text('Age')),
                                      DataColumn(label: Text('Email')),
                                    ],
                                    rows: _buildDataRows(snapshot.data!),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildDataRows(List<Map<String, dynamic>> data) {
    List<DataRow> rows = [];
    for (var item in data) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(item['name'].toString())),
          DataCell(Text(item['surname'].toString())),
          DataCell(Text(item['age'].toString())),
          DataCell(Text(item['email'].toString())),
        ],
      ));
    }
    return rows;
  }

  void _showSavedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saved'),
        content: const Text('Information saved successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
