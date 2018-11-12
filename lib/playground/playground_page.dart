import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/playground/bubble_widget.dart';
import 'package:shiffr_wallet/playground/item_detailed_page.dart';

class PlaygroundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text("Playground main"),
        ),
        body: _buildBody(context),
      );

//  _buildBody(BuildContext context) => Container(
//        padding: EdgeInsets.all(32.0),
//        alignment: Alignment.center,
//        child: Column(
//          children: <Widget>[
//            BubbleWidget(
//              title: "Buubble 1"
//                  "238/12",
//              bgColor: Color(int.parse("0x637693")),
//              textColor: Colors.white,
//              radius: 50,
//            ),
//            Padding(padding: EdgeInsets.all(16.0)),
//            BubbleWidget(
//              title: "Buubble 2"
//                  "238/12",
//              bgColor: Colors.blue[800],
//              textColor: Colors.white,
//              radius: 70,
//            )
//          ],
//        ),
//      );
  _buildBody(BuildContext context) => AnimatedList(
      initialItemCount: 10,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) {
        return _buildListItem(context, index);
      });

  _buildListItem(BuildContext context, int index) {
    //every url should be different, otherwise all pictures retrieved from cacche
    var imageUrl = "https://source.unsplash.com/random/100x${100 + index}";
    return GestureDetector(
        onTap: () => navigateTo(context, ItemDetailedPage(imageUrl)),
        child: Card(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHero(imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Some name $index"),
            )
          ],
        )));
  }

  Widget _buildHero(String imageUrl) => Hero(
      tag: imageUrl,
      child: Container(
          height: 100.0,
          width: 100.0,
          child: FadeInImage.assetNetwork(
            image: imageUrl,
            placeholder: "", //todo
          )));
}
