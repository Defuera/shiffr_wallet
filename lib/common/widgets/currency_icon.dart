import 'package:flutter/material.dart';

const _fiatTextStyle = TextStyle(fontSize: 56.0);

class CurrencyIcon extends StatelessWidget {
  final String _symbol;

  CurrencyIcon(this._symbol);

  @override
  Widget build(BuildContext context) {
    switch (_symbol) {
      case "USD":
        return Text(
          "\$",
          style: _fiatTextStyle,
        );
      case "EUR":
        return Text(
          "€",
          style: _fiatTextStyle,
        );
      default:
        return Image(
          image: AssetImage("assets/symbols/${toCryptoImageAssetName()}.png"),
          //todo what if asset not found?,
          height: 56.0,
          width: 56.0,
          color: Colors.white,
          colorBlendMode: BlendMode.srcOut,
        );
    }
  }

  toCryptoImageAssetName() {
    switch(_symbol){
      case "IOT":
        return "miota";
      case "DSH":
        return "dash";
      default:
        return _symbol.toLowerCase();
    }
  }
}
