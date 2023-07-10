import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 191, 99),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag, size: 30),
                onPressed: () {
                  // Alım İkonu tıklandığında yapılacak işlemler
                },
              ),
              Text(
                'Buy',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.home, size: 30),
                onPressed: () {
                  // Anasayfa İkonu tıklandığında yapılacak işlemler
                },
              ),
              Text(
                'Home',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, size: 30),
                onPressed: () {
                  // Satım İkonu tıklandığında yapılacak işlemler
                },
              ),
              Text(
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
