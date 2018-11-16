xxximport 'package:flutter/material.dart';

class BaseCurrencyWidget extends StatelessWidget {
  final String symbol;
  final double amount;

  BaseCurrencyWidget(this.symbol, this.amount);

  @override
  Widget build(BuildContext context) => Text(
        createString(),
        style: Theme.of(context).textTheme.subtitle,
      );

  createString() {
    switch (symbol) {
      case "USD":
        return "\$$amount";
      case "EUR":
        return "€$amount";
      case "RUB":
        return "₽$amount";
      case "GBP":
        return "£$amount";
      default:
        return "$amount $symbol";
    }
  }

}
