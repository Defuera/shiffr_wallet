import 'package:flutter/material.dart';

class SymbolText extends StatelessWidget {
  final String symbol;
  final int size;

  SymbolText(this.symbol, {this.size: 0});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.headline;
    if (size != 0) {
      style = style.copyWith(fontSize: 12.0);
    }

    return Text(symbol, style: style,);
  }
}
