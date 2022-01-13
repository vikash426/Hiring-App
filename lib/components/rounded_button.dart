import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({this.text="Click", this.color = Colors.blue, @required this.onPress});
  final String text;
  final Color color;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(0.0),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPress,
          padding: EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white,fontSize: 18),
          ),
        ),
      ),
    );
  }
}