import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/widgets/chart_mode.dart';

class ChartRadio extends StatefulWidget {
  final ChartMode value;
  final ChartMode groupValue;
  final ValueChanged<ChartMode> onChanged;

  ChartRadio({
    Key key,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => ChartRadioState();
}

class ChartRadioState extends State<ChartRadio> {
  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment(0, 0),
        width: 44.0,
        height: 44.0,
        color: Theme.of(context).accentColor,
        child: Text(_getTitle()),
      );

  String _getTitle() {
    switch (widget.value) {
      case ChartMode.ONE_HOUR:
        return "1H";
      case ChartMode.ONE_DAY:
        return "1D";
      case ChartMode.ONE_WEEK:
        return "1W";
      case ChartMode.ONE_MONTH:
        return "1M";
      case ChartMode.ONE_YEAR:
        return "1Y";
      case ChartMode.ALL_TIME:
        return "ALL";
      default:
        throw Exception("unkhown chart mode");
    }
  }
}
