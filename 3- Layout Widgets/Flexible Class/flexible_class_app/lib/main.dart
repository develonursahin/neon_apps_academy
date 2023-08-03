import 'package:flexible_class_app/widgets/bottom_navigation_widget.dart';
import 'package:flexible_class_app/widgets/chart/chart_widget.dart';
import 'package:flexible_class_app/widgets/currency_cards_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Member {
  String fullName;
  String? gender;
  Map<Currencies, double> accountBalances = {};
  Member({required this.fullName, required this.gender}) : accountBalances = {};
}

class Currencies {
  String? moneyName;
  String? currencySymbol;
  double? instantValue;

  Currencies({
    required this.moneyName,
    required this.currencySymbol,
    required this.instantValue,
  });
}

// Defaults
Member member = Member(fullName: "Onur", gender: 'Mr.');
List<Currencies> currenciesList = [
  Currencies(moneyName: "Dollar", currencySymbol: "USD", instantValue: 26.45),
  Currencies(moneyName: "Euro", currencySymbol: "EUR", instantValue: 27.28),
  Currencies(moneyName: "Sterling", currencySymbol: "GBP", instantValue: 33.27),
  Currencies(
      moneyName: "Swiss Frank", currencySymbol: "CHF", instantValue: 29.14),
  Currencies(moneyName: "Ripple ", currencySymbol: "XRP", instantValue: 12.15),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fin Smart',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 191, 99),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 170,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 191, 99),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 150,
                            height: 150,
                            child: Image(
                              image: AssetImage('assets/images/logo2.png'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Row(
                              children: [
                                Text(
                                  "Hello, ${member.gender} ${member.fullName}   |   ",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const Icon(
                                  Icons.person_sharp,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CurrencyCards(),
              Chart(currenciesList: currenciesList),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
