import 'package:flutter/material.dart';

class Passenger {
  final String name;
  final String surname;
  final String team;
  final int age;
  final String hometown;
  final String mail;

  Passenger({
    required this.name,
    required this.surname,
    required this.team,
    required this.age,
    required this.hometown,
    required this.mail,
  });
}

class DataTableScreen extends StatelessWidget {
  DataTableScreen({Key? key}) : super(key: key);

  final List<Passenger> passengers = [
    Passenger(
      name: 'Onur',
      surname: 'Şahin',
      team: 'Flutter Team',
      age: 30,
      hometown: 'İstanbul',
      mail: 'onur@example.com',
    ),
    Passenger(
      name: 'Mehmet Nuri',
      surname: 'Fırat',
      team: 'iOS Team',
      age: 28,
      hometown: 'Ankara',
      mail: 'mehmetnuri@example.com',
    ),
    Passenger(
      name: 'Doğukan Özgür',
      surname: 'Yılmaz',
      team: 'Android Team',
      age: 32,
      hometown: 'İzmir',
      mail: 'dogukan@example.com',
    ),
    Passenger(
      name: 'Atakan',
      surname: 'Alkan',
      team: 'Design Team',
      age: 26,
      hometown: 'Bursa',
      mail: 'atakan@example.com',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger List'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Surname')),
              DataColumn(label: Text('Team')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Hometown')),
              DataColumn(label: Text('Mail')),
            ],
            rows: passengers.map((passenger) {
              return DataRow(cells: [
                DataCell(Text(passenger.name)),
                DataCell(Text(passenger.surname)),
                DataCell(Text(passenger.team)),
                DataCell(Text(passenger.age.toString())),
                DataCell(Text(passenger.hometown)),
                DataCell(Text(passenger.mail)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class PassengerDetailsScreen extends StatelessWidget {
  final Passenger passenger;

  PassengerDetailsScreen({required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Details'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${passenger.name}'),
            Text('Surname: ${passenger.surname}'),
            Text('Team: ${passenger.team}'),
            Text('Age: ${passenger.age}'),
            Text('Hometown: ${passenger.hometown}'),
            Text('Mail: ${passenger.mail}'),
          ],
        ),
      ),
    );
  }
}
