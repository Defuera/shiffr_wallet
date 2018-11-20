import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';
import 'package:shiffr_wallet/common/utils/ticker_utils.dart';
import 'package:shiffr_wallet/common/widgets/base_currency_widget.dart';
import 'package:shiffr_wallet/common/widgets/currency_icon.dart';
import 'package:shiffr_wallet/common/widgets/paddings.dart';
import 'package:shiffr_wallet/common/widgets/symbol_text_widget.dart';

const _MARKET_CAP_DECIMAL_PLACES = 0;
const _PERC_DECIMAL_PLACES = 0;

class TickerWidget extends StatelessWidget {
  final Ticker _ticker;

  TickerWidget(this._ticker);

  @override
  Widget build(BuildContext context) {
    final ticker = _ticker;
    final symbol = retrieveQuoteCurrency(_ticker.symbol);
    final base = retrieveBaseCurrency(_ticker.symbol);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CurrencyIcon(symbol),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Column(
              children: <Widget>[
                SymbolText(symbol),
                Text("") //todo how do I find currency name?
              ],
            ),
            HorizontalPadding(8.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  BaseCurrencyWidget(base, _ticker.lastPrice),
                  VerticalPadding(12.0),
                  Text(
                    "MC: ${ticker.marketCap().toStringAsFixed(_MARKET_CAP_DECIMAL_PLACES)}",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  VerticalPadding(8),
                  Text(
                    trendText(ticker),
                    style: Theme.of(context).textTheme.body1.copyWith(color: _getColor(ticker)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String trendText(Ticker ticker) {
    var dailyChangePerc = ticker.dailyChangePerc * 100;
    return "(${dailyChangePerc.toStringAsFixed(_PERC_DECIMAL_PLACES)}%) ${ticker.dailyChange.toStringAsFixed(0)}";
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
