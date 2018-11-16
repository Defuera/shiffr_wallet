import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';
import 'package:shiffr_wallet/common/widgets/base_currency_widget.dart';
import 'package:shiffr_wallet/common/widgets/symbol_text_widget.dart';
import 'package:shiffr_wallet/wallets_list/wallet_ticker.dart';

class WalletTickerWidget extends StatelessWidget {
  final WalletTicker _walletTicker;

  WalletTickerWidget(this._walletTicker);

  @override
  Widget build(BuildContext context) {
    final ticker = _walletTicker.ticker;
    return Card(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.money_off,
              size: 72.0,
            ),
            Column(
              children: <Widget>[
                SymbolText(_walletTicker.symbol),
                Text("") //todo how do I find currency name?
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: <Widget>[
                  BaseCurrencyWidget("USD", _walletTicker.wallet.amount),
                  Text(
                    "(${ticker.dailyChangePerc}%) ${ticker.dailyChange}",
                    style: Theme.of(context).textTheme.body1.copyWith(color: _getColor(ticker)),
                  ) //todo
                ],
              ),
            )
          ],
        ),
      );
  }

  Color _getColor(Ticker ticker) {
    var dailyChangePerc = ticker.dailyChangePerc;
    if (dailyChangePerc == null || dailyChangePerc >= 0){
      return Colors.green; //todo get from Theme
    } else {
      return Colors.red;
    }
  }
}
