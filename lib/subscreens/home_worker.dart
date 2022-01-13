import 'package:flutter/material.dart';
import 'package:hire_stream/models/booking.dart';
import 'package:provider/provider.dart';
import 'package:hire_stream/components/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire_stream/components/rounded_button.dart';
import 'package:hire_stream/services/api.dart';
//import 'package:hire_stream/screens/workers_screen.dart';

class HomeScreenEmployee extends StatefulWidget {
  @override
  _HomeScreenEmployeeState createState() => _HomeScreenEmployeeState();
}

class _HomeScreenEmployeeState extends State<HomeScreenEmployee> {
  Widget getText(Booking b){
    if(b.status==0){
      return Text("Waiting For Approval",style: TextStyle(color: Colors.red.shade400));
    
    }
    else if(b.status==1){
      return Text("Approved",style: TextStyle(color: Colors.blue.shade400));
      
    }
    
    else if(b.status==2){
      return Text("Complete",style: TextStyle(color: Colors.blue.shade400));
    }
    else
    return Text("Rejected",style: TextStyle(color: Colors.red.shade400));
    
  }

  void _showBottomSheet(BuildContext context,List<Booking> bookings,int index) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (builder) {
          return new Container(
            padding: EdgeInsets.all(16.0),
            height:900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(bookings[index].custName,style:TextStyle(fontSize: 22,color: Colors.black87,fontWeight: FontWeight.bold)),
                SizedBox(height:4),
                Text(bookings[index].id,style:TextStyle(fontSize: 16,color:Colors.black87)),
                SizedBox(height:2),
                Text(bookings[index].custEmail,style:TextStyle(fontSize: 16,color:Colors.black87)),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(bookings[index].time,style: TextStyle(fontSize: 18,color: Colors.black87))),
                Divider(thickness: 2.0),
               // Text(_workers[index].description,style:TextStyle(fontSize: 16,color:Colors.black87)),
                Expanded(
                                  child: bookings[index].status!=0?Container():Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RoundedButton(
                                        color:Theme.of(context).accentColor,
                                        text:"Accept",
                                        onPress: () async{
                                        
                                        String res=await Api().updateStatus(bookings[index].id, 1);
                                         if(res=="1"){
                                           Fluttertoast.showToast(msg: "Updated");
                                           bookings[index].status=1;
                                           Provider.of<List<Booking>>(context)[index].status=1;
                                           Navigator.pop(context);
                                           setState(() {
                                             
                                           });
                                         }
                                         else
                                         Fluttertoast.showToast(msg: res);
                                      }),
                                      FlatButton(onPressed: () async{
                                        String res=await Api().updateStatus(bookings[index].id, 3);
                                        if(res=="1"){
                                           Fluttertoast.showToast(msg: "Updated");
                                           bookings[index].status=1;
                                           Provider.of<List<Booking>>(context)[index].status=1;
                                           Navigator.pop(context);
                                           setState(() {
                                             
                                           });
                                         }
                                         else
                                         Fluttertoast.showToast(msg: res);
                                      }, child: Text("Reject",style:TextStyle(color:Colors.red,fontSize: 18)))
                                    ],
                                  ),
                )
              ],
            ),
          );
        });
  }
  

  @override
  Widget build(BuildContext context) {
   // List<Employee> _workers = Provider.of<List<Employee>>(context);
    List<Booking> _bookings = Provider.of<List<Booking>>(context);
    
    return _bookings == null
        ? Container(child: CupertinoActivityIndicator(radius: 50.0))
        : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:30),
            Text("Unfinished Works",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.black87)),
            SizedBox(height:16.0),
            Expanded(
                child: ListView.builder(
                    itemCount: _bookings.length,
                    itemBuilder: (context, index) {
                      return _bookings[index].status<2? RoundedContainer(
                        leading: Text(_bookings[index].custName,style:TextStyle(fontSize: 16,)),
                      trailing: getText(_bookings[index]),
                      onPress: (){
                        _showBottomSheet( context, _bookings, index);
                        //Navigator.push(context, MaterialPageRoute(builder:(context)=>WorkersScreen(_jobs[index])));
                      },
                      ):SizedBox(height:0.0);
                    }),
              ),
          ],
        );
  }
}




