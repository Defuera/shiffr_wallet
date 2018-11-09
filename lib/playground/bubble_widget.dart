import 'package:flutter/material.dart';

class BubbleWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color textColor;
  final int radius;

  BubbleWidget({this.title, this.subtitle, this.bgColor, this.textColor, this.radius});

  @override
  State<StatefulWidget> createState() {
    return _BubbleWidgetState(title, subtitle, bgColor, textColor, radius);
  }
}

class _BubbleWidgetState extends State<BubbleWidget> {
  final String _title;
  final String _subtitle;
  final Color _bgColor;
  final Color _textColor;
  final int _radius;

  _BubbleWidgetState(this._title, this._subtitle, this._bgColor, this._textColor, this._radius);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackgroundWidget(_radius, _bgColor),
        Text(_title, style: TextStyle(fontSize: 12.0, ),)
      ],
    );
  }

  Widget _buildBackgroundWidget(int radius, Color bgColor) {
    return Container(
      width: radius * 2.0,
      height: radius * 2.0,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
    );
  }
}

//class M extends CustomPaint
