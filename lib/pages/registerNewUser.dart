
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project Library Import
import '../shelf.dart';


// Registration Class for creating a new account
class RegsiterNewUser extends StatefulWidget {

  // Constructor
  RegsiterNewUser(this.authorized);

  // Abstract Class for FireBase Interaction
  final AbsFireBaseAuthorization authorized;

  
  @override
  State<StatefulWidget> createState() {
    return _RegisterNewUser();
  }
}



class _RegisterNewUser extends State<RegsiterNewUser> {


  // Form Key For debugging Purpuses
  final _formKey = new GlobalKey<FormState>();


  // Class Variables
  String _email;
  String _password;
  bool _isLoading;
  String _errorMessage;
  bool _isIos;


  // Validates Formkey for Submission
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
      }
      return false;
      }


  // Main Registration Function - Surrounded in Try - Catch
  void _validateAndSubmit() async {

    // Set state for error Message
    setState(() {
      _errorMessage = "";
      _isLoading = true;

    });

    // Form Validation
    if (_validateAndSave()) {

      // UserId Collected from FireBase after succesful submission
      String userId = "";

      try {

          // E-Mail - Password sent to FireBase with Abstract Class
          userId = await widget.authorized.registerNewUser(_email, _password);

          // Send Email Verifaction
          widget.authorized.sendEmailVerification();

          // Push to Resistration Page - Collection or More information
          // pages/register.dart
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(userId)
            )
          );
          print('Signed up user: $userId');
        
        // Set State for Error Mesages - False
        setState(() {
          _isLoading = false;
        });


        // Catch Block for Error Message Collection and console print
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }


  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }


  // Building of New User Registraion Page - Email and Password Collection
  @override
  Widget build(BuildContext context) {
    return BaseBackground(
        Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _showInput('Email'),
                _showInput('Password'),
                _showPrimaryButton()
              ],
            ),
          ),
        ),
        'assets/hum_shake_purp_middle.png');
  }


  // Creating Import Buttons
  Widget _showInput(String type) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: TextFormField(
          maxLines: 1,
          keyboardType: type == "Email" ? TextInputType.emailAddress : null,
          obscureText: type == "Password" ? true : false,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: '$type',
              icon: new Icon(
                type == "Email" ? Icons.mail : Icons.lock,
                color: Colors.white,
              )),
          validator: (value) => value.isEmpty ? '$type can\'t be empty' : null,
          onSaved: (value) =>
              type == "Email" ? _email = value : _password = value,
        ));
  }


  // Creating Account Button
  Widget _showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 75.0),
        child: SizedBox(
          height: 40.0,
          child: MaterialButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.purple,
              child: new Text('Create account',
              style: new TextStyle(fontSize: 17.5, color: Colors.white)),
              onPressed: _validateAndSubmit,
              splashColor: Colors.purpleAccent),
        ));
  }
}
