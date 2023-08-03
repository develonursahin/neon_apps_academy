import 'package:flexible_class_app/main.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalSales {
  final String currency;
  final int amount;

  OrdinalSales(this.currency, this.amount);
}

class GraphicWidget extends StatelessWidget {
  final List<charts.Series<OrdinalSales, String>> seriesList;
  final bool animate;

  const GraphicWidget(this.seriesList, {super.key, required this.animate});

  factory GraphicWidget.withSampleData(List<Currencies> currenciesList) {
    return GraphicWidget(
      _sampleData(currenciesList),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: const charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            color: charts.Color.white,
          ),
          labelAnchor: charts.TickLabelAnchor.after,
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.white,
            thickness: 10,
          ),
          labelRotation: 12,
          axisLineStyle: charts.LineStyleSpec(
            color: charts.Color.white,
          ),
        ),
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _sampleData(
      List<Currencies> currenciesList) {
    final data = currenciesList.map((currency) {
      return OrdinalSales(
        currency.currencySymbol!,
        currency.instantValue!.toInt(),
      );
    }).toList();

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Wallet',
        domainFn: (OrdinalSales sales, _) => sales.currency,
        measureFn: (OrdinalSales sales, _) => sales.amount,
        data: data,
      ),
    ];
  }
}
