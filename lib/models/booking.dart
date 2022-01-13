import 'package:hire_stream/services/api.dart';

class Booking{
  String id,custId,empId,custName,custEmail,time,empName;
  int status;
  

  Booking({this.id,this.custId,this.empId,this.status,this.custName,this.custEmail,this.time,this.empName});

  factory Booking.fromJson(Map<String,dynamic> json){
    return Api.currentUserType=="customer"?Booking(
      id: json['_id'] as String,
     // custName:json['cust'][0]['cust_name'] as String,
      //custEmail:json['cust'][0]['cust_email'] as String,
      empName:json['emp'][0]['emp_name'] as String,
      //custId: json['cust_id'] as String,
      empId: json['emp_id'] as String,
      status: json['status'] as int,
      time: json['time'] as String
      ):
      Booking(
        id: json['_id'] as String,
      custName:json['cust'][0]['cust_name'] as String,
      custEmail:json['cust'][0]['cust_email'] as String,
      //empName:json['emp'][0]['emp_name'] as String,
      custId: json['cust_id'] as String,
      //empId: json['emp_id'] as String,
      status: json['status'] as int,
      time: json['time'] as String
      )
      ;
  }
}