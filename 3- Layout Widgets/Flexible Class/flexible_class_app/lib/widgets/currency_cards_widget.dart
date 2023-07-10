import 'dart:math';
import 'package:flexible_class_app/main.dart';
import 'package:flutter/material.dart';

class CurrencyCards extends StatelessWidget {
  const CurrencyCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final random = Random();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.03,
          left: screenWidth * 0.03,
          right: screenWidth * 0.03,
        ),
        child: Row(
          children: List.generate(
            currenciesList.length,
            (index) {
              final cardWidth = screenWidth * 0.25;
              final cardHeight = screenHeight * 0.3;

              final isIncrease = random.nextBool();
              final icon =
                  isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
              final iconColor =
                  isIncrease ? Color.fromARGB(255, 0, 229, 255) : Colors.red;

              return SizedBox(
                height: cardHeight,
                width: cardWidth,
                child: Card(
                  color: Color.fromARGB(255 - index * 40, 0, 191, 99),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${currenciesList[index].moneyName}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "${currenciesList[index].currencySymbol}\n",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        Text(
                          "${currenciesList[index].instantValue}\n",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          icon,
                          color: iconColor,
                          size: screenWidth * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
