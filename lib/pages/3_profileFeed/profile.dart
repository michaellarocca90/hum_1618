
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import '../../shelf.dart';

class Profile extends StatefulWidget{
  final String userID;
  Profile(this.userID);

  @override
  State<StatefulWidget> createState() => ProfileState(userID);

}
class ProfileState extends State<Profile>{

  final String userID;
  final _biggerFonts = const TextStyle(fontSize: 18.0);
  final ProfileMAP usProfile = new ProfileMAP();
  
  int _tabIndex = 0;
  String picURL = "";

  ProfileState(this.userID);

  @override
  Widget build(BuildContext context) {

    final bottonBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.face), title: Text('Profile')),
      BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), title: Text('Items')),
      BottomNavigationBarItem(icon: Icon(Icons.public), title: Text('Meetup')),
    ];

    final bottomBar = BottomNavigationBar(
      items: bottonBarItems,
      currentIndex: _tabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
        _tabIndex = index;
        });
      },
    );

    return Scaffold(

      backgroundColor: Colors.transparent,
      body: FutureBuilder (
      future: _createPictureProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasData) {

          _createPictureProfile();
          return BaseBackground('assets/android-purple-gradient.png',
          
          Material(
            color: new Color.fromRGBO(0, 0, 0, 0.3),
            child: ListView.separated(

              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemCount: usProfile.pArray.length + 1,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int i){

                if (i == 0){
                  return _profilePicture(picURL);

                }else{
                  final index = i - 1;
                  return _profileTextRow(index);}
                },
              )
            )
          );
        } else {
          return new CircularProgressIndicator();
        }
      }
    ),
    bottomNavigationBar: bottomBar,
  );
  }

  Widget _profileTextRow(int index){

    Widget _textItem(int index){

      return StreamBuilder(
        stream: Firestore.instance
        .collection('users')
        .document(userID)
        .snapshots(),

        builder: (context, snapshot){

          if (snapshot.hasData){
            var profileItem = snapshot.data;

            if (profileItem.exists){
              return Text(
                profileItem[usProfile.pArray[index]],
                style: _biggerFonts,);
            }
          }
          return new Container(width: 0.0, height: 0.0);
        },
      );
    }
    return ListTileTheme(
      child: ListTile(
        title: _textItem(index),
        subtitle: Text(usProfile.disArray[index])
        )
    );
  }


  Widget _profilePicture(String picURL){

    return Container(
      child: 
      Center(
        child: this.picURL == ""? Placeholder(): Image.network(this.picURL),
      )
    );
  }

  Future<void> _createPictureProfile() async{

    final StorageReference ref = FirebaseStorage.instance.ref().child(userID + ".png");
    String downloadURL = await ref.getDownloadURL();

    //downloadURL = Uri.decodeFull(downloadURL);
    picURL = Uri.decodeFull(downloadURL);
    return downloadURL;
  }
}