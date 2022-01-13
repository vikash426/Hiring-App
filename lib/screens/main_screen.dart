
import 'package:flutter/material.dart';
import 'package:hire_stream/models/bookingProvider.dart';
import 'package:hire_stream/subscreens/home_worker.dart';
import 'package:hire_stream/subscreens/profile_screen.dart';
import 'package:hire_stream/subscreens/home_client.dart';
//import 'package:hire_stream/models/employee.dart';
import 'package:hire_stream/services/api.dart';
import 'package:provider/provider.dart';
import 'package:hire_stream/models/jobProvider.dart';
import 'package:hire_stream/subscreens/myBookings.dart';
import 'package:hire_stream/subscreens/comp_bookings.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int currentIndex=0;
  List<Widget> _children=[
    Api.currentUserType=="employee"?HomeScreenEmployee():HomeScreenWorker(),
    Api.currentUserType=="employee"?CompleteBookings():MyBookings(),
    ProfileScreen(),
    
  ];
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      FutureProvider(builder: (_)=>JobProvider().getJobs()),
      FutureProvider(builder:(_)=>BookingProvider().getBookings(Api.currentUser))
      
    ],
    child:
    SafeArea(
          child:  Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Color(0xFF9CADE6),
            onTap: (value){
              setState(() {
                currentIndex=value;
              });
            },
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),title:Text("Home")),
              BottomNavigationBarItem(icon: Icon(Icons.event_note),title:Text("Orders")),
              BottomNavigationBarItem(icon: Icon(Icons.person),title:Text("Profile")),
              
            ]),
        body: _children[currentIndex],      
      ),
        
    ));
  }
}