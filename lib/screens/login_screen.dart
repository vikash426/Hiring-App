import 'package:flutter/material.dart';
import 'package:hire_stream/components/rounded_button.dart';
import 'package:hire_stream/components/form_field.dart';
import 'package:hire_stream/screens/register_screen.dart';
import 'package:hire_stream/services/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hire_stream/screens/main_screen.dart';
import 'package:hire_stream/services/validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  String email,password;

  int _radioValue;

  void handleRadioValue(int value) {
    setState(() {
      _radioValue = value;
      print(_radioValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Form(
          key: formkey,
          autovalidate: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text("Get your work done by experience workers"),
                  SvgPicture.asset("images/ic.svg",height: 200,),
                  SizedBox(height: 16.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Client",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: handleRadioValue)
                          ],
                        ),
                        Column(
                          children: [
                            Text("Worker",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Radio(
                                value: 2,
                                groupValue: _radioValue,
                                onChanged: handleRadioValue)
                          ],
                        )
                      ]),
                      
                  InputFormField(hint: "Enter Your Email",onChange: (value)=>email=value,validator: (value)=>checkEmail(value),),
                  SizedBox(height: 16.0),
                  InputFormField(hint: "Enter Password", obscure: true,onChange: (value)=>password=value,validator:(value)=>checkLength(value)),
                  SizedBox(height: 16.0),
                  Text("Forgot Password?",
                      style: TextStyle(color: Color(0xFF4C63B4))),
                  SizedBox(height: 16.0),
                  RoundedButton(
                      onPress: () async{
                        print(_radioValue);
                        if(formkey.currentState.validate()){

                        String res= await Api().login(email, password,_radioValue);
                        if(res=="1"){
                          Fluttertoast.showToast(msg: "Logged in");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                        }
                        else{
                          Fluttertoast.showToast(msg: res);
                        }
                      }
                      },
                      color: Theme.of(context).accentColor,
                      text: "Log in"),
                  SizedBox(height: 16.0),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account?  "),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
                        child: Text("Sign up",
                            style:
                                TextStyle(color: Theme.of(context).accentColor)))
                  ])
                ],
              ),
            ),
          )),
    );
  }
}
