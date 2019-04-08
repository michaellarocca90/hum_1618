import 'package:flutter/material.dart';

class Feed2 extends StatelessWidget {
  final List<Map> inNeeds = [
    {'name': 'Jerry'},
    {'name': 'Tony'},
    {'name': 'Sue'}
  ];

  Feed2();

  Widget _buildFeedItem(BuildContext context, int index) {
    return Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: (MediaQuery.of(context).size.height) / 2.7,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset('assets/Splash_wider.jpg'),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.add_circle),
                        color: Colors.black45,
                        onPressed: () {
                          print(inNeeds[index]['name']);
                        },
                      ),
                    )
                  ],
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple[100],
        child: ListView.builder(
          itemBuilder: _buildFeedItem,
          itemCount: inNeeds.length,
        ));
  }
}