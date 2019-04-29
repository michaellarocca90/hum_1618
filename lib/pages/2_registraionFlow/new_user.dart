
import 'package:flutter/material.dart';
import '../../shelf.dart';


class NewUser extends StatefulWidget {

  final AbsFireBaseAuthorization authorized;
  NewUser(this.authorized);

  @override
  State<StatefulWidget> createState() {
    return _RegisterNewUser();
  }
}

class _RegisterNewUser extends State<NewUser> {

  String _email;
  String _password;
  String _password2;
  String _errorMessage;
  bool _isIos;
  bool _isLoading;
  bool _checkBoxVal = true;

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

      userId = await widget.authorized.registerNewUser(_email, _password);
      widget.authorized.sendEmailVerification();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(userId)
        )
      );

      print('Signed up user: $userId');

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Registration Successful."),
        ));

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

                Divider(),

                _showInput('Password'),

                _showInput('Re-type Password'),

                Divider(),

                Text('By signing up, you agree to our Terms & Conditions.'),
                Checkbox(
                  onChanged: (bool value) {
                    setState(() => this._checkBoxVal = value);
                  },
                  value: this._checkBoxVal,
                ),

                CommonAppButtons.function(
                  AppButtonType.FUNCTION,
                  "Sign Up",
                  Alignment.center,
                  new BorderRadius.circular(40.0),
                  new TextStyle(fontSize: 25),
                  _validateAndSubmit)],
                  
            ),
          ),
        )
      );
  }

  Widget _showInput(String type) {

    return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: TextFormField(

          maxLines: 1,

          keyboardType: type == "Email" ? TextInputType.emailAddress : null,

          obscureText: (type == "Password" || type == "Re-type Password")? true : false,

          autofocus: false,

          decoration: new InputDecoration(

              hintText: '$type',

              icon: new Icon(

                type == "Email" ? Icons.mail : Icons.lock,

                color: Colors.white,

              )),

          validator: (value) => 
          
            value.isEmpty ? '$type can\'t be empty' : null,

          onSaved: (value) =>

            (type == "Email")? _email = value:
            (type == "Password")? _password = value: _password2 = value

        )
      );
  }


}
