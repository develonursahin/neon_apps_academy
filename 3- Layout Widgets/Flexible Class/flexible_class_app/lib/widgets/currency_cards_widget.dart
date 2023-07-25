import 'dart:math';
import 'package:flexible_class_app/main.dart';
import 'package:flutter/material.dart';

class CurrencyCards extends StatelessWidget {
  const CurrencyCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final random = Random();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: List.generate(
            currenciesList.length,
            (index) {
              final cardWidth = MediaQuery.of(context).size.width * 0.2;

              final isIncrease = random.nextBool();
              final icon =
                  isIncrease ? Icons.arrow_upward : Icons.arrow_downward;
              final iconColor =
                  isIncrease ? Color.fromARGB(255, 0, 229, 255) : Colors.red;

              return SizedBox(
                height: 250,
                width: cardWidth,
                child: Card(
                  color: Color.fromARGB(255 - index * 40, 0, 191, 99),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${currenciesList[index].moneyName}",
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        "${currenciesList[index].currencySymbol}\n",
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        "${currenciesList[index].instantValue}\n",
                        style: textTheme.titleLarge,
                      ),
                      Icon(
                        icon,
                        color: iconColor,
                        size: 30,
                      ),
                    ],
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
