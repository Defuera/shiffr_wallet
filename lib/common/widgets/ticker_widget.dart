import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';
import 'package:shiffr_wallet/common/widgets/symbol_text_widget.dart';

class TickerWidget extends StatelessWidget {
  final Ticker _ticker;

  TickerWidget(this._ticker);

  @override
  Widget build(BuildContext context) {
    final ticker = _ticker;
    final symbol = _ticker.symbol;

    final currencyImage = AssetImage("assets/symbols/${symbol.toLowerCase()}.png"); //todo what if asset not found?
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image(
              image: currencyImage,
              height: 56.0,
              width: 56.0,
              color: Colors.white,
              colorBlendMode: BlendMode.srcOut,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Column(
              children: <Widget>[
                SymbolText(symbol),
                Text("") //todo how do I find currency name?
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
//                  BaseCurrencyWidget("USD", _ticker.wallet.amount),
                  Text(
                    "(${ticker.dailyChangePerc}%) ${ticker.dailyChange}",
                    style: Theme.of(context).textTheme.body1.copyWith(color: _getColor(ticker)),
                  ) //todo
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getColor(Ticker ticker) {
    var dailyChangePerc = ticker.dailyChangePerc;
    if (dailyChangePerc == null || dailyChangePerc >= 0) {
      return Colors.green; //todo get from Theme
    } else {
      return Colors.red;
    }
  }
}
