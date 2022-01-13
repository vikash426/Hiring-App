import 'package:flutter/material.dart';
import 'package:hire_stream/constants.dart';
import 'package:hire_stream/components/rounded_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name, email, password;

  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  bool validate = false;

  String checkEmail(String val) {
    if (val.length.toInt() > 0) {
      var check = RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(val);
      if (!check) {
        return "invalid Email";
      }
      return null;
    } else
      return "Please Enter Email";
  }

  String checkPass(String val) {
    if (val.length.toInt() > 0) {
      if (val.length.toInt() < 6) {
        return "Password too short";
      }
      return null;
    } else
      return "Please enter Password ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formkey,
        autovalidate: this.validate,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Register", style: kPrimaryTextStyle),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: kInputDecoration.copyWith(hintText: "Username"),
                onChanged: (value) => name = value,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                validator: (val) => checkEmail(val),
                onChanged: (value) => email = value,
                decoration: kInputDecoration.copyWith(hintText: "Email"),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                validator: (val) => checkPass(val),
                onChanged: (value) => password = value,
                decoration: kInputDecoration.copyWith(hintText: "Password"),
              ),       
              SizedBox(height: 12.0),
              RoundedButton(
                onPress: () {
                  var form = formkey.currentState;
                  if (form.validate()) {
                    form.save();
                  }
                },
                text: "Sign Up",
              )
            ],
          ),
        ),
      )),
    );
  }
}
