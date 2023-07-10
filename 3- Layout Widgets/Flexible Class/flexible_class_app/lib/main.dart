import 'package:flexible_class_app/widgets/bottom_navigation_widget.dart';
import 'package:flexible_class_app/widgets/chart/chart_widget.dart';
import 'package:flexible_class_app/widgets/currency_cards_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fin Smart',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 0, 191, 99),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 191, 99),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70, bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 180,
                          height: 90,
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "Hello, ${member.gender} ${member.fullName}   |   ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Icon(Icons.person_sharp)
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 10),
                              child: SearchBar(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                  maxHeight: 30,
                                ),
                                hintText: "Search...",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CurrencyCards(),
            Chart(currenciesList: currenciesList),
            BottomNavigation()
          ],
        ),
      ),
    );
  }
}
