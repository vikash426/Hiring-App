import 'package:flutter/material.dart';
import 'package:hire_stream/services/api.dart';
import 'package:hire_stream/components/rounded_container.dart';
import 'package:hire_stream/models/employee.dart';
import 'package:flutter/cupertino.dart';
import 'package:hire_stream/models/job.dart';
import 'package:hire_stream/components/rounded_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:hire_stream/helpers/app_dialogs.dart';


class WorkersScreen extends StatefulWidget {
  final selectedJob;
  WorkersScreen(this.selectedJob);
  @override
  _WorkersScreenState createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  Job selectedJob;
  List<Employee> _workers;
  bool k = true;

  void getJobs() async {
    _workers = await Api().getWorkers(selectedJob.id);
    _workers.sort((a,b)=>b.review.compareTo(a.review));
    setState(() {
      k = false;
    });
  }

  @override
  void initState() {
    selectedJob = widget.selectedJob;
    getJobs();
    super.initState();
  }

  void _showBottomSheet(int index) {
    print(_workers[index].id);
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (builder) {
          return new Container(
            padding: EdgeInsets.all(16.0),
            height: 900,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_workers[index].name,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text(_workers[index].email,
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                Text(_workers[index].number,
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(_workers[index].rate.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold))),
                Divider(thickness: 2.0),
                Text(_workers[index].description,
                    style: TextStyle(fontSize: 16, color: Colors.black87)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StatefulBuilder(builder: (context, StateSetter setState) {
                        return Row(children: [
                          Text(
                              _chosenDateTime != null
                                  ?  DateFormat('yyyy-MM-dd – kk:mm').format(_chosenDateTime)
                                  : "No Date Time Picked",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18)),
                          IconButton(
                              icon: Icon(Icons.timer),
                              onPressed: () async{
                                await _showDatePicker(context).then((value){
                                setState((){
                                  print("v");
                                });
                                });
                              })
                        ]);
                      }),
                      RoundedButton(
                          color: Theme.of(context).accentColor,
                          text: "Send Request",
                          onPress: () async {
                            if(_chosenDateTime==null){
                              Fluttertoast.showToast(msg: "Please Select Date and Time");
                            }
                            else{
                            String res = await Api().bookWorker(selectedJob.id,
                                Api.currentUser, _workers[index].id,DateFormat('yyyy-MM-dd – kk:mm').format(_chosenDateTime));
                            if (res == "1") {
                              showD(context:context, title:"Request Send",content: "Please wait for workers response....");
                            } else
                              showD(context:context,title:res);
                          }}),
                    ],
                  ),
                )
              ],
            ),
          );
        }).whenComplete(() => _chosenDateTime=null);
  }

  DateTime _chosenDateTime;
  Future<void> _showDatePicker(ctx) async{
    // showCupertinoModalPopup is a built-in function of the cupertino library
    await showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          _chosenDateTime = val;
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
            )).whenComplete(() {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: k
                ? Container(child: CupertinoActivityIndicator(radius: 50.0))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context).accentColor,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.pop(context)),
                            SizedBox(width: 100),
                            Text(selectedJob.jobName,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.builder(
                              itemCount: _workers.length,
                              itemBuilder: (context, index) {
                                return RoundedContainer(
                                    onPress: () => _showBottomSheet(index),
                                    leading: Row(
                                      children: [
                                        Icon(Icons.person,
                                            color:
                                                Theme.of(context).accentColor),
                                        SizedBox(width: 8),
                                        Text(_workers[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        SizedBox(width: 8),
                                        Icon(Icons.star,color:Colors.yellow),
                                        Text(" ${_workers[index].review}")
                                      ],
                                    ),
                                    trailing:
                                        Text(_workers[index].rate.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                            )));
                              }),
                        ),
                      ],
                    ),
                  )));
  }
}
