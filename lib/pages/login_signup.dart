import 'package:flutter/material.dart';
import '../auth.dart';
import '../widgets/base_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../register.dart';

class LoginSignup extends StatefulWidget {
  final BaseAuth auth;
  bool isLogin;
  LoginSignup(this.auth, this.isLogin);

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
          //userId?? need user info -> registration flow
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(userId)
            )
          );
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
    _formMode = widget.isLogin ? FormMode.LOGIN : FormMode.SIGNUP;
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
                _showPrimaryButton()
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

  Widget _showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 75.0),
        child: SizedBox(
          height: 40.0,
          child: MaterialButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.purple,
              child: _formMode == FormMode.LOGIN
                  ? new Text('Login',
                      style: new TextStyle(fontSize: 17.5, color: Colors.white))
                  : new Text('Create account',
                      style:
                          new TextStyle(fontSize: 17.5, color: Colors.white)),
              onPressed: _validateAndSubmit,
              splashColor: Colors.purpleAccent),
        ));
  }
}
