import 'package:flutter/material.dart';

//import '../shelf.dart';



class HumTextField extends StatelessWidget {
  final String _label;
  final TextEditingController _controller;

  HumTextField(this._label, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: new TextFormField(
          controller: _controller,
          validator: (value) {
            if (value.isEmpty) {
              return "Field `$_label` cannot be blank";
            }
          },
          decoration: new InputDecoration(
              labelText: _label,
              fillColor: Colors.white.withOpacity(.25),
              filled: true,
              border: OutlineInputBorder()),
        ));
  }
}

