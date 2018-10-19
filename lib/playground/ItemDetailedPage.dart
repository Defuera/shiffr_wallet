import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetailedPage extends StatefulWidget {

  final String _imageUrl;

  ItemDetailedPage(this._imageUrl);

  @override
  State<StatefulWidget> createState() => ItemDetailedPageState(_imageUrl);

}

class ItemDetailedPageState extends State<ItemDetailedPage> {

  final String _imageUrl;

  ItemDetailedPageState(this._imageUrl);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text("Item Detailed Page"),
        ),
        body: _buildBody(context),
      );

  _buildBody(BuildContext context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 100.0,
              width: 100.0,
              child: FadeInImage.assetNetwork(
                image: _imageUrl,
                placeholder: "", //todo
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Some name"),
          )
        ],
      );
}
