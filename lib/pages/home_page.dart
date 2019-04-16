import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../base_background.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection("users").snapshots(),
    builder: (BuildContext context, 
              AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) return new Text('${snapshot.error}');
      if (snapshot.data == null) {
        return new Text("No data");
      }
      
      if (snapshot.data != null && snapshot.data.documents != null) {
        // return ListView.builder(
        //   // padding: const EdgeInsets.all(16.0),
        //   itemBuilder: (context, i){
        //     // final index = i % snapshot.data.documents.length;
        //     return Card(
        //       child: _buildUserInfo(snapshot.data.documents[1]),
        //     );
      
        //   },
        // );
        return _buildUserInfo(snapshot.data.documents[1]);
      }

      return  new Text('');
      

    },
  );

  //  return BaseBackground(
  //    Container(child: Text("hi")), "assets/hum_shake_purp_large.jpg");
  }

  Widget _buildUserInfo(DocumentSnapshot document) {
    // final document = snapshot.data.documents[index];
    final email = document["email"];
    final videoUrl = document["video"];
    final profile = document["profile"];
    final name = profile["first_name"] + " " + profile["last_name"];
    final age = profile["age"];
    final language = profile["language"];
    final zipcode = profile["zip_code"];

    return Scaffold(
      body: ListView(
         children: <Widget>[
           ListTile(
            title: Text("Email: " + email + "\n"),
           ),
            ListTile(
              title: Text("Name: " + name + "\n"),
            ),
            ListTile(
              title: Text("Age: " + age + "\n"),
            ),
            ListTile(
              title: Text("Language: " + language + "\n"),
            ),
            ListTile(
              title: Text("Zipcode: " + zipcode + "\n"),
            ),
          ],
      ),
    );
  }
}