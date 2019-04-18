import 'package:flutter/material.dart';


class HumCustomTextField extends StatelessWidget {
  final FormField _formField;

  HumCustomTextField(this._formField);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 6.0), child: _formField);
  }
}

