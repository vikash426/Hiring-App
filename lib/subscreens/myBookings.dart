import 'package:flutter/material.dart';
import 'package:hire_stream/helpers/app_dialogs.dart';
import 'package:hire_stream/models/booking.dart';
//import 'package:provider/provider.dart';
import 'package:hire_stream/components/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:hire_stream/components/rounded_button.dart';
import 'package:hire_stream/services/api.dart';
//import 'package:hire_stream/screens/workers_screen.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
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

  List<Booking> _bookings;
  void getBookings() async {
    _bookings = await Api().getBookingsCust(Api.currentUser);
    setState(() {});
  }

  @override
  void initState() {
    getBookings();
    super.initState();
  }

  
    
  double r=0;
  @override
  Widget build(BuildContext context) {
    // List<Employee> _workers = Provider.of<List<Employee>>(context);
    // List<Booking> _bookings = Provider.of<List<Booking>>(context);
    return _bookings == null
        ? Container(child: CupertinoActivityIndicator(radius: 50.0))
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text("My Bookings",
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
                        leading: Text(_bookings[index].empName,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                        trailing: getText(_bookings[index]),
                        below: _bookings[index].status != 1
                            ? SizedBox()
                            : OutlineButton(
                                onPressed: () {
                                  showRatingDialog(
                                      context: context,
                                      onSubmit: () async {
                                        String res = await Api().updateReview(
                                            _bookings[index].empId, r.toInt(),_bookings[index].id);

                                        if (res == "1") {
                                          Fluttertoast.showToast(
                                              msg: "Thank you");
                                              Navigator.pop(context);
                                              setState(() {
                                                _bookings[index].status=2;
                                              });
                                              
                                        } else
                                          Fluttertoast.showToast(msg: res);
                                      },
                                      onUpdate: (response){
                                        r=response;
                                        print(r);
                                      });
                                },
                                child: Text("Complete",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor))),
                        onPress: null,
                      );
                    }),
              ),
            ],
          );
  }
}
