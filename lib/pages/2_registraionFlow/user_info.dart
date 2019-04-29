
// Flutter Imports
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'dart:async';

// Project Library Import
import '../../shelf.dart';


class RegisterPage extends StatelessWidget {
  final String userId;

  RegisterPage(this.userId);

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
       "assets/hum_shake_purp_large.jpg",
        RegisterForm(userId));
  }
}

class RegisterForm extends StatefulWidget {
  final String userId;

  RegisterForm(this.userId);
  @override
  RegisterFormState createState() {
    return RegisterFormState(userId);
  }
}

class RegisterFormState extends State<RegisterForm> {

  RegisterFormState(this.userID);

  File _imageFile;

  final String userID;
  final _formKey = GlobalKey<FormState>();
  String _gender;
  String _type;
  bool _optedIn = false;
  bool _submitted = false;

  List<String> _categories = ["Male", "Female", "Prefer not to say"];
  List<String> _types = ["In Need", "Willing to Help"];

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController zipController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();


  Future<String> _pickSaveImage(String imageId) async {
  File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
  StorageReference ref =
    FirebaseStorage.instance.ref().child(imageId).child("image.jpg");
  StorageUploadTask uploadTask = ref.putFile(imageFile);
  return await (await uploadTask.onComplete).ref.getDownloadURL();
}

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Form(

      key: _formKey,

      child: new ListView(

        padding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 40.0),

        children: <Widget>[

          new HumTextField("First Name", firstNameController),
          new HumTextField("Last Name", lastNameController),
          new HumDropdown("Gender", _categories, _gender, setGender),
          new HumCustomTextField(new TextFormField(

            controller: zipController,
            decoration: new InputDecoration(
                labelText: "ZIP Code",
                fillColor: Colors.white.withOpacity(.35),
                filled: true,
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (value) {

              if (value.isEmpty) {
                return "Field `ZIP Code` cannot be blank";
              }

              if (int.tryParse(value) == null) {
                return "Field `ZIP Code` is invalid";
              }
            },
          )),

          new HumDropdown("Type", _types, _type, setType),
          new HumCustomTextField(new TextFormField(
            controller: bioController,
            decoration: new InputDecoration(
                labelText: "Bio (optional)",
                fillColor: Colors.white.withOpacity(.35),
                filled: true,
                border: OutlineInputBorder()),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          )),

          new HumCheckbox(
            "Allow access to location data",
            _optedIn,
            setOptedIn,
            validateOptIn(_optedIn),
          ),

          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () async => await _pickImageFromCamera(),
                tooltip: 'Shoot picture',
              ),
              
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () async => await _pickImageFromGallery(),
                tooltip: 'Pick from gallery',
              ),
            ],
          ),
          this._imageFile == null ? Placeholder() : Image.file(this._imageFile),

          new Container(
              padding: const EdgeInsets.only(top: 40.0),
              child: 

              CommonAppButtons.function(
              AppButtonType.FUNCTION, 
              "Submit",
              Alignment.center,
              new BorderRadius.circular(40.0),
              new TextStyle(fontSize: 25),
              _buttonPress)
             ),
        ],
      ),
    ));
  }

  void _buttonPress(){

    setState(() {
      _submitted = true;
      });
      
    if (_formKey.currentState.validate() && _optedIn) {

      Firestore.instance
      .collection('users')
      .document(widget.userId)
      .setData({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'gender': _gender,
        'type': _type,
        'zip_code': zipController.text,
        'bio' :bioController.text
        });


      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(userID + ".png");
      final StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);


      Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Successfully registered!"),
      ));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(userID)
      )
    );
  }

  void setGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  void setType(String type) {
    setState(() {
      _type = type;
    });
  }

  void setOptedIn(bool optedIn) {
    setState(() {
      _optedIn = optedIn;
    });
  }

  Text validateOptIn(bool ok) {
    if (!ok && _submitted) {
      return Text(
        "Required",
        style: TextStyle(color: Colors.red),
      );
    }

    return null;
    }

    Future<Null> _pickImageFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() => this._imageFile = imageFile);
  }

  Future<Null> _pickImageFromCamera() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => this._imageFile = imageFile);
  }





}
