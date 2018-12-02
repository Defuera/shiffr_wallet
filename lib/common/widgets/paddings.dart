import 'package:flutter/material.dart';

class HorizontalPadding extends StatelessWidget {

  final double _value;
  HorizontalPadding(this._value);

  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(horizontal: _value));
}

class VerticalPadding extends StatelessWidget {

  final double _value;
  VerticalPadding(this._value);

  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(top: _value));
}
