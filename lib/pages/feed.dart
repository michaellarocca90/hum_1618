import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Feed2 extends StatelessWidget {
  final List<Map> inNeeds = [
    {'name': 'Jerry'},
    {'name': 'Tony'},
    {'name': 'Sue'}
  ];

  Feed2();

  Widget _buildFeedItem(BuildContext context, DocumentSnapshot document) {
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
                          //print(inNeeds[index]['name']);
                          if(document["profile"] != null)
                            print(document["profile"]["first_name"]);
                          else {
                            print("No first_name provided");
                          }  
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
    return Scaffold(
        body: StreamBuilder(
              stream: Firestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index) => 
                    _buildFeedItem(context, snapshot.data.documents[index]),
               );
              }
        ));
  }
}
