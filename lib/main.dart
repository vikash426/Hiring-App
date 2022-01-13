import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
//import 'package:hire_stream/screens/worker_details_screen.dart';
//import 'screens/main_worker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hire Stream',
        theme: ThemeData(
          cursorColor: Colors.black87,
          scaffoldBackgroundColor: Color(0xFFD9E4E4),
          accentColor: Color(0xFF4C63B4),
        ),
        home: LoginScreen());
  }
}


