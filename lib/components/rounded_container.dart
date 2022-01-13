import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  final Widget below;
  final Function onPress;

  RoundedContainer({this.leading, this.trailing,this.onPress,this.below=const SizedBox(height:0.0)});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
          child: Container(
        margin: EdgeInsets.symmetric(vertical:6.0,horizontal:30.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [leading, trailing]),
              below,
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white),
      ),
    );
  }
}