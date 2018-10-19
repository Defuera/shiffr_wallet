import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetailedPage extends StatefulWidget {
  final String _imageUrl;

  ItemDetailedPage(this._imageUrl);

  @override
  State<StatefulWidget> createState() => _ItemDetailedPageState(_imageUrl);
}

class _ItemDetailedPageState extends State<ItemDetailedPage> {
  final String _imageUrl;

  _ItemDetailedPageState(this._imageUrl);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text("Item Detailed Page"),
        ),
        body: _buildBody(context),
      );

  _buildBody(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(color: Colors.lightBlueAccent, child: _buildHero()),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "And the name of this beautiful picture is unknown",
            style: TextStyle(fontSize: 22.0),
          ),
        )
      ]);

  Widget _buildHero() => Hero(
      tag:  _imageUrl,
      child: AspectRatio(
          aspectRatio: 1.0 / 1.0,
          child: Image.network(
            _imageUrl,
            fit: BoxFit.fitWidth,
          )));
}
