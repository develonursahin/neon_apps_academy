import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: const Color.fromARGB(255, 0, 191, 99),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag, size: 30),
                onPressed: () {
                  // Alım İkonu tıklandığında yapılacak işlemler
                },
              ),
              const Text(
                'Buy',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.home, size: 30),
                onPressed: () {
                  // Anasayfa İkonu tıklandığında yapılacak işlemler
                },
              ),
              const Text(
                'Home',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 30),
                onPressed: () {
                  // Satım İkonu tıklandığında yapılacak işlemler
                },
              ),
              const Text(
                'Sell',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
