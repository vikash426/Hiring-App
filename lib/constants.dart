import 'package:flutter/material.dart';

InputDecoration kInputDecoration= InputDecoration(
   
    isDense: true,
    contentPadding: EdgeInsets.all(12.0),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black45),
        ),
    enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black45),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.black45),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.red),
        )
  );


const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 22,
  color: Color(0xffFEFEFE),
);

const kshape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

const kContainerDecoration = BoxDecoration(
  color:Color(0xFF9E9E9E),
  
   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  
);

const TextStyle kAppBarTextStyle = TextStyle(
  fontSize: 20,
);
const TextStyle kPrimaryTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold
);
const TextStyle kSecondaryTextStyle = TextStyle(
  fontSize: 16,
);