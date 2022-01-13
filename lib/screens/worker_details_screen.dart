import 'package:flutter/material.dart';
import 'package:hire_stream/components/rounded_button.dart';
import 'package:hire_stream/components/form_field.dart';
import 'package:hire_stream/services/api.dart';
// import 'package:hire_stream/screens/register_screen.dart';
// import 'package:hire_stream/services/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire_stream/services/validator.dart';
import 'package:hire_stream/models/job.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  List<Job> _jobs;
  bool k=true;
  String number, jobDescription,rate;


  Job selectedJob ;

  

  void getJobs() async{
    _jobs=await Api().getJobs();
    setState(() {
      k=false;     
    });
  }
  
  @override
  void initState() {
    getJobs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print(_jobs[0].jobName);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: k?Container(child: CupertinoActivityIndicator(radius: 50.0)):
        Form(
            key: formkey,
            autovalidate: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Complete Your Worker Profile !",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    InputFormField(
                        hint: "Enter Phone Number",
                        onChange: (value) => number = value,
                        validator: (value)=>checkNumber(value),),
                    SizedBox(height: 16.0),
                    DropdownButton(                 
                      isExpanded:true,
                      hint: Text("Select Your Job"),
                        value: selectedJob,
                        items: _jobs.map((e){
                          return DropdownMenuItem(child: Text(e.jobName),value:e);
                        }).toList(),
                        onChanged: (value) {                          
                          setState(() {
                            selectedJob = value;
                          });
                        }),
                    SizedBox(height: 16.0),
                    InputFormField(
                        hint: "Job Description",
                        max:3,
                        onChange: (value) => jobDescription = value,
                        validator: (value)=>checkdescription(value),
                        ),
                    SizedBox(height: 16.0),
                    InputFormField(
                        hint: "Service Rate",
                        onChange: (value) {
                          rate=value;               
                        },
                        validator: (value)=>checkLength(value),),
                    SizedBox(height: 16.0),
                    RoundedButton(
                      
                        onPress: () async{
                          if(formkey.currentState.validate()){
                          String res=await Api().updateEmployee(number, selectedJob.id, jobDescription, int.parse(rate));

                          if(res=="1"){
                            Fluttertoast.showToast(msg: "Details Succesfully Added Login To Go Ahead");
                            Navigator.pop(context);
                          }
                          else{
                            Fluttertoast.showToast(msg: res);
                          }}
                        },
                        color: Theme.of(context).accentColor,
                        text: "Update"),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
