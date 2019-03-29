import 'package:flutter/material.dart';
import 'auth.dart';

class LoginSignup extends StatefulWidget {
  final BaseAuth auth;

  LoginSignup(this.auth);

  @override
  State<StatefulWidget> createState() {
    return _LoginSignupState();
  }
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignupState extends State<LoginSignup> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  bool _isLoading;
  String _errorMessage;
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;


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
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          // _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        // if (userId.length > 0 && userId != null && _formMode == FormMode.LOGIN) {
        //   widget.onSignedIn();
        // }

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

//implement signUp button swap which leads to Profile Info Flow.  


  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Hum')),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[_showInput('Email'), _showInput('Password'), _showPrimaryButton()],
          ),
        ),
      ),
    );
  }

  Widget _showInput(String type) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: type == "Email" ? TextInputType.emailAddress : null,
        obscureText: type == "Password" ? true : false,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: '$type',
            icon: new Icon(
              type == "Email" ? Icons.mail : Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? '$type can\'t be empty' : null,
        onSaved: (value) =>
            type == "Email" ? _email = value : _password = value,
      ),
    );
  }

   Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}
