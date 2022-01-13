import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Function onChange;
  final int max;
  final Function validator;
  InputFormField({@required this.hint,this.obscure=false,this.onChange,this.max=1,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      maxLines:max,
      onChanged: onChange,
        obscureText: obscure,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
            isDense: true,
            fillColor: Colors.white70,
            filled: true,
            hintText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(25.0))));
  }
}
