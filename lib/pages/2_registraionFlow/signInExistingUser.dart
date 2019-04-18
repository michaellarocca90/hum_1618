
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project Library Import
import '../../shelf.dart';



// LoginExistingUser Class - For signing an Existing User
class LoginExistingUser extends StatefulWidget {

  // Constucutor - with fireBaseAurthdation class for an argument
  LoginExistingUser(this.authorized);


  // Form - fireBaseAurthorization
  final AbsFireBaseAuthorization authorized;


  @override
  State<StatefulWidget> createState() {
    return _LoginExistingUserState();
  }
}



class _LoginExistingUserState extends State<LoginExistingUser> {


  // Form Key - For debugging Purpures
  final _formKey = new GlobalKey<FormState>();


  // Member Variables
  String _email;
  String _password;
  bool _isLoading;
  String _errorMessage;
  bool _isIos;


  // Form Validation for Correct Error debugging
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    
    if (_validateAndSave()) {
      String userId = "";
      try {

        // Main Call for User Log-IN
        userId = await widget.authorized.loginExistingUser(_email, _password);
        
          print('Signed in: $userId');

          setState(() {
            _isLoading = false;
            });

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
               CommonAppButtons.function(
                  AppButtonType.FUNCTION,
                  "Create Account",
                  Alignment.center,
                  new BorderRadius.circular(40.0),
                  new TextStyle(fontSize: 25),
                  _validateAndSubmit)
              ],
            ),
          ),
        ),
        'assets/hum_shake_purp_middle.png');
  }

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
}
