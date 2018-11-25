import 'package:flutter/material.dart';

const DECIMAL_PLACES = 2;

class BaseCurrencyWidget extends StatelessWidget {
  final String _symbol;
  final double _amount;
  final double textSize;

  BaseCurrencyWidget(this._symbol, this._amount, {this.textSize});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.headline;
    if (textSize != null) {
      style = style.copyWith(fontSize: textSize);
    }
    return Text(
      createString(),
      style: style,
    );
  }

  createString() {
    final roundedAmount = _amount.toStringAsFixed(DECIMAL_PLACES).replaceAll(".00", "");

    switch (_symbol) {
      case "USD":
        return "\$$roundedAmount";
      case "EUR":
        return "€$roundedAmount";
      case "RUB":
        return "₽$roundedAmount";
      case "GBP":
        return "£$roundedAmount";
      default:
        return "$roundedAmount $_symbol";
    }
  }
}
