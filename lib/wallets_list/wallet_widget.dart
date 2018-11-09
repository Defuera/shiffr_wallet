import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';

class WalletWidget extends StatelessWidget {
  final Wallet _wallet;

  WalletWidget(this._wallet);

  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.all(16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Text(
          _wallet.currency,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "${_wallet.amount}",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
        )
      ]));
}
