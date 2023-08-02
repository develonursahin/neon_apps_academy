import 'package:flutter/material.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchBarScreenState createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final List<Person> _people = [
    Person(name: 'Mini', surname: 'Mouse', team: 'Flutter Team'),
    Person(name: 'Mickey', surname: 'Mouse', team: 'Flutter Team'),
    Person(name: 'Donald', surname: 'Duck', team: 'iOS Team'),
    Person(name: 'Goofy', surname: 'Goof', team: 'Android Team'),
    Person(name: 'Daisy', surname: 'Duck', team: 'Design Team'),
  ];
  List<Person> _filteredPeople = [];

  final TextEditingController _searchController = TextEditingController();
  String _searchCategory = 'Name';

  @override
  void initState() {
    super.initState();
    _filteredPeople = List.from(_people);
  }

  void _filterPeople() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPeople = _people
          .where((person) =>
              person.name.toLowerCase().contains(query) ||
              person.surname.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onSearchCategoryChanged(String? value) {
    if (value != null) {
      setState(() {
        _searchCategory = value;
      });
      _filterPeople();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Bar Challenge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => _filterPeople(),
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Search by:'),
                const SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: _searchCategory,
                  onChanged: _onSearchCategoryChanged,
                  items: <String>['Name', 'Surname'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPeople.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${_filteredPeople[index].name} ${_filteredPeople[index].surname}',
                    ),
                    subtitle: Text(_filteredPeople[index].team),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  final String name;
  final String surname;
  final String team;

  Person({
    required this.name,
    required this.surname,
    required this.team,
  });
}
