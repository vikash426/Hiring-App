import 'package:flutter/material.dart';
import 'package:hire_stream/helpers/app_dialogs.dart';
import 'package:hire_stream/models/booking.dart';
import 'package:provider/provider.dart';
import 'package:hire_stream/components/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:hire_stream/components/rounded_button.dart';
import 'package:hire_stream/services/api.dart';
//import 'package:hire_stream/screens/workers_screen.dart';

class CompleteBookings extends StatefulWidget {
  @override
  _CompleteBookingsState createState() => _CompleteBookingsState();
}

class _CompleteBookingsState extends State<CompleteBookings> {
  Widget getText(Booking b) {
    if (b.status == 0) {
      return Text("Waiting For Approval",
          style: TextStyle(color: Colors.red.shade400));
    } else if (b.status == 1) {
      return Text("Approved", style: TextStyle(color: Colors.blue.shade400));
    } else if (b.status == 2) {
      return Text("Complete", style: TextStyle(color: Colors.blue.shade400));
    } else
      return Text("Rejected", style: TextStyle(color: Colors.red.shade400));
  }

  
  
  
    
  double r=0;
  @override
  Widget build(BuildContext context) {
    
     List<Booking> _bookings = new List<Booking>.from(Provider.of<List<Booking>>(context));
     _bookings.removeWhere((element) => element.status<2);
    return _bookings == null
        ? Container(child: CupertinoActivityIndicator(radius: 50.0))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text("Completed Orders",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      return RoundedContainer(
                        leading: Text(_bookings[index].custName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        trailing: getText(_bookings[index]),
                        onPress: null,
                      );
                    }),
              ),
            ],
          );
  }
}
