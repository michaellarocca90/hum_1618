
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project Library Import
import '../splash.dart';

class UserProfile extends StatefulWidget{

  String userEmail;
  String firstname;
  String lastName;



  @override
  State<StatefulWidget> createState(){
    return _UserProfile();
  }



}

class _UserProfile extends State<UserProfile>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  
  // Widget _showInput(String type) {
  //   return Padding(
  //       padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
  //       child: TextFormField(
  //         maxLines: 1,
  //         keyboardType: type == "Email" ? TextInputType.emailAddress : null,
  //         obscureText: type == "Password" ? true : false,
  //         autofocus: false,
  //         decoration: new InputDecoration(
  //             hintText: '$type',
  //             icon: new Icon(
  //               type == "Email" ? Icons.mail : Icons.lock,
  //               color: Colors.white,
  //             )),
  //         validator: (value) => value.isEmpty ? '$type can\'t be empty' : null,
  //         onSaved: (value) =>
  //             type == "Email" ? _email = value : _password = value,
  //       ));
  // }

  // Widget _showPrimaryButton() {
  //   return Padding(
  //       padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 75.0),
  //       child: SizedBox(
  //         height: 40.0,
  //         child: MaterialButton(
  //             shape: new RoundedRectangleBorder(
  //                 borderRadius: new BorderRadius.circular(30.0)),
  //             color: Colors.purple,
  //             child: new Text('Login',
  //             style: new TextStyle(fontSize: 17.5, color: Colors.white)),
  //             onPressed: _validateAndSubmit,
  //             splashColor: Colors.purpleAccent),
  //       ));
  // }





}