import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: double.infinity,
            color: Color(0xFF9CADE6),
            height: 300,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        'P',
                        style: TextStyle(fontSize: 25),
                      ),
                      maxRadius: 60.0),
                  SizedBox(height: 20.0),
                  Text(
                    "Welcome, User!",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                ])),
        Expanded(
            child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            SizedBox(height: 16.0),
          //  buildRow("Email", "ahmed@gmail.com")
          ]),
        ))
      ],
    );
  }

  Row buildRow(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(key,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold)),
        SizedBox(width: 16),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(value,
              style: TextStyle(fontSize: 18, color: Colors.black54)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white70),
        )
      ],
    );
  }
}
