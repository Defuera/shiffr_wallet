//amount, creationTimestamp, type, price, orderStatus
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shiffr_wallet/common/model/model_order.dart';

class OrderListItemWidget extends StatelessWidget {
  final Order _order;
  final bool _showDivider;

  OrderListItemWidget(this._order, this._showDivider);

//  [amount, creationTimestamp, type, price, orderStatus]
  @override
  Widget build(BuildContext context) {
    if (_showDivider) {
      return Column(children: <Widget>[
        Divider(
          height: 2.0,
          color: Colors.grey,
        ),
        _buildWidget(),
      ]);
    } else {
      return _buildWidget();
    }
  }

  Container _buildWidget() {
    var amountString = getAmountString();

    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Text(
                amountString,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: getAmountColor(amountString)),
              ),
              Text(
                "${_order.price}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ]),
            Padding(padding: EdgeInsets.only(top: 4.0)),
            Row(children: <Widget>[
              Text(
                _getDate(_order.updateTimestamp),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              )
            ]),
            Padding(padding: EdgeInsets.only(top: 4.0)),
            Text(
              "order status: ${_order.orderStatus}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.grey),
            ),
            Padding(padding: EdgeInsets.only(top: 4.0)),
            Text("order type: ${_order.type}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal), textAlign: TextAlign.left),
          ],
        ));
  }

  String getAmountString() {
    final total = _order.amountOriginal;
    final actual = _order.amount;

    if (actual == 0.0) {
      return total.toString();
    } else if (total != actual) {
      return "$actual of $total";
    } else {
      return actual.toString();
    }
  }

  String _getDate(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    if (dateTime.isAfter(today)) {
      return "today " + DateFormat("dd-MM-yyyy HH:mm").format(dateTime);
    } else {
      return DateFormat("dd-MM-yyyy HH:mm").format(dateTime);
    }
  }

  getAmountColor(String amountString) {
    if (amountString.contains('-')) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}
