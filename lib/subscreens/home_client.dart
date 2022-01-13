import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hire_stream/components/rounded_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:hire_stream/models/job.dart';
import 'package:hire_stream/screens/workers_screen.dart';

class HomeScreenWorker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // List<Employee> _workers = Provider.of<List<Employee>>(context);
    List<Job> _jobs = Provider.of<List<Job>>(context);
    return _jobs == null
        ? Container(child: CupertinoActivityIndicator(radius: 50.0))
        : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:30),
            Text("Job Categories",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.black87)),
            SizedBox(height:16.0),
            Expanded(
                child: ListView.builder(
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      return RoundedContainer(
                        leading: Text(_jobs[index].jobName,style:TextStyle(fontSize: 16,)),
                      trailing: Icon(Icons.person,color: Theme.of(context).accentColor),
                      onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>WorkersScreen(_jobs[index])));
                      },
                      );
                    }),
              ),
          ],
        );
  }
}




