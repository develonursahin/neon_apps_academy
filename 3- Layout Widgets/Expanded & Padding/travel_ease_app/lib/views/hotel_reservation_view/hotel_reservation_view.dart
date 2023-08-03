import 'package:flutter/material.dart';

class HotelReservationPage extends StatelessWidget {
  const HotelReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Reservation'),
      ),
      body: const Center(
        child: Text('Hotel Reservation Page'),
      ),
    );
  }
}
