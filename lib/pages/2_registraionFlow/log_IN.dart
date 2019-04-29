

import 'package:flutter/material.dart';
import '../../shelf.dart';

class LogIN extends StatefulWidget {

  final AbsFireBaseAuthorization authorized;

  LogIN(this.authorized);

  @override
  State<StatefulWidget> createState() {
    return _LogINState();
  }
}

class _LogINState extends State<LogIN> {

  String _email;
  String _password;
  bool _isLoading;
  String _errorMessage;
  bool _isIos;

  final _formKey = new GlobalKey<FormState>();


  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    
    if (_validateAndSave()) {
      String userId = "";
      try {

        userId = await widget.authorized.loginExistingUser(_email, _password);
        print('Signed in: $userId');

        setState(() {
          _isLoading = false;
          });

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(userId)));

        // Scaffold.of(context).showSnackBar(SnackBar(
        // content: Text("Sign-In Successful"),
        // ));

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
  Widget build(BuildContext context) {
    return BaseBackground( 'assets/hum_shake_purp_middle.png',

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
                  "Sign In",
                  Alignment.center,
                  new BorderRadius.circular(40.0),
                  new TextStyle(fontSize: 25),
                  _validateAndSubmit)
              ],

            ),
          )
        )
    );
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
