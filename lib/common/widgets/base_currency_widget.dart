import 'package:flutter/material.dart';

const DECIMAL_PLACES = 2;

class BaseCurrencyWidget extends StatelessWidget {
  final String symbol;
  final double amount;

  BaseCurrencyWidget(this.symbol, this.amount);

  @override
  Widget build(BuildContext context) => Text(
        createString(),
        style: Theme.of(context).textTheme.headline,
      );

  createString() {
    final roundedAmount = amount
        .toStringAsFixed(DECIMAL_PLACES)
        .replaceAll(".00", "");

    switch (symbol) {
      case "USD":
        return "\$$roundedAmount";
      case "EUR":
        return "€$roundedAmount";
      case "RUB":
        return "₽$roundedAmount";
      case "GBP":
        return "£$roundedAmount";
      default:
        return "$roundedAmount $symbol";
    }
  }


}
