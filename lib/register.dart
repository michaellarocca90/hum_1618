import 'package:flutter/material.dart';
import 'base_background.dart';
import 'common/hum_textfield.dart';
import 'common/hum_customtextfield.dart';
import 'common/hum_dropdown.dart';
import 'common/hum_checkbox.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseBackground(RegisterForm(), "assets/hum_shake_purp_middle.png");
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
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
                fillColor: Colors.white.withOpacity(.25),
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
                fillColor: Colors.white.withOpacity(.25),
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
          new Container(
              padding: const EdgeInsets.only(top: 40.0),
              child: new RaisedButton(
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.purple,
                onPressed: () {
                  setState(() {
                    _submitted = true;
                  });

                  if (_formKey.currentState.validate() && _optedIn) {
                    // TODO: POST data
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Successfully registered!"),
                    ));
                  }
                },
              )),
          new Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: new RaisedButton(
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                color: Colors.grey.withOpacity(.2),
                onPressed: () => {Navigator.pop(context)},
              ))
        ],
      ),
    ));
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
}
