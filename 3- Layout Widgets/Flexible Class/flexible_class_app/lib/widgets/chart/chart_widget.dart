import 'package:flexible_class_app/main.dart';
import 'package:flexible_class_app/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Currencies> currenciesList;

  const Chart({Key? key, required this.currenciesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 250,
        child: Card(
          color: const Color.fromARGB(255, 0, 191, 99),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Card(
              color: const Color.fromARGB(255, 0, 60, 40),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GraphicWidget.withSampleData(currenciesList),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
