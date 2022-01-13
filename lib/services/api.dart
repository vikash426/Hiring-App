import 'package:hire_stream/models/booking.dart';
import 'package:hire_stream/models/employee.dart';
import 'package:hire_stream/models/job.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api{

  static String currentUser;
  static String currentUserType;
  static String insertedId;
  final String _url="http://10.0.2.2:8081";

  Future<List<Job>> getJobs()async{

    List<Job> ps=[];
    try {
      final response = await http.get(_url+'/fetch_jobs');
      
      if(response.statusCode==200){
        List p = jsonDecode(response.body);
        ps = p.map((json) => Job.fromJson(json)).toList();  
      }
      return ps;
    } catch (e) {
      print(e);
      return ps; 
  }
  }
  Future<List<Employee>> getWorkers(int jobId)async{
    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    List<Employee> ps=[];
    try {
      final response = await http.post(_url+'/retrieve_workers',headers: headers,
      body: json.encode(
            {
              'job_id': jobId,
            }
          )
      );
      
      if(response.statusCode==200){
        List p = jsonDecode(response.body);
        ps = p.map((json) => Employee.fromJson(json)).toList();  
      }
      return ps;
    } catch (e) {
      print(e);
      return ps; 
  }
  }
  Future<List<Booking>> getBookings(String empId)async{
    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    List<Booking> ps=[];
    try {
      final response = await http.post(_url+'/fetch_bookings',headers: headers,
      body: json.encode(
            {
              'emp_id': empId,
            }
          )
      );
      
      if(response.statusCode==200){
        List p = jsonDecode(response.body);
        ps = p.map((json) => Booking.fromJson(json)).toList();  
      }
      return ps;
    } catch (e) {
      print(e);
      return ps; 
  }
  }
  Future<List<Booking>> getBookingsCust(String empId)async{
    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    List<Booking> ps=[];
    try {
      final response = await http.post(_url+'/fetch_bookings_cust',headers: headers,
      body: json.encode(
            {
              'cust_id': empId,
            }
          )
      );
      
      if(response.statusCode==200){
        print(response.body);
        List p = jsonDecode(response.body);
        ps = p.map((json) => Booking.fromJson(json)).toList();  
      }
      return ps;
    } catch (e) {
      print(e);
      return ps; 
  }
  }
  
  Future<String> registerEmployee(String name, String email,String password) async {

    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/add_employee",headers: headers,
          body: json.encode(
            {
              'name': name,
              'email': email,
              'password': password
            }
          ));

      if(response.statusCode==200){
        final Map user=json.decode(response.body);
        print(user['data']['insertedId']);
        insertedId=user['data']['insertedId'] as String;
        print(insertedId);
        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> bookWorker(int jobId, String custId,String empID,String dateTime) async {

    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/book_worker",headers: headers,
          body: json.encode(
            {
              'job_id': jobId,
              'cust_id': custId,
              'emp_id': empID,
              'time':dateTime
            }
          ));

      if(response.statusCode==200){
      //  final Map user=json.decode(response.body);
        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> registerCustomer(String name, String email,String password) async {

    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/add_customer",headers: headers,
          body: json.encode(
            {
              'name': name,
              'email': email,
              'password': password
            }
          ));

      if(response.statusCode==200){

        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> login(String email,String password,int value) async
  {
     Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/login",headers: headers,
          body: json.encode(
            {
              'email': email,
              'password': password,
              'usertype':value
            }
          ));

      if(response.statusCode==200){
        final Map user=json.decode(response.body);
        currentUser=user['data']['_id'];
        currentUserType=user['user'];
        print("Current User - "+currentUser);

        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> updateReview(String empId,int rating,String id) async{
    Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/update_review",headers: headers,
          body: json.encode(
            {
              'emp_id': empId,
              'review': rating,
            }
          ));
      
      if(response.statusCode==200){
        print("up");
      final res=await updateStatus(id, 2);
      if(res=="1")
        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> updateEmployee(String number,int jobId, String description,int rate) async
  {
    print(insertedId);
     Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/update_employee",headers: headers,
          body: json.encode(
            {
              'number': number,
              'job_id': jobId,
              'description': description,
              'rate':rate,
              '_id':insertedId
            }
          ));

      if(response.statusCode==200){
        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
  Future<String> updateStatus(String id,int status) async
  {
    print(id);
     Map<String,String> headers={
      'Content-Type':'application/json',
      'Accept': 'application/json'
    }    ;
    try {
      final response = await http.post(_url+"/update_status",headers: headers,
          body: json.encode(
            {
              'status':status,
              '_id':id
            }
          ));

      if(response.statusCode==200){
        return "1";
      }     
      return response.body;
    } catch (e) {
      print(e);
      return "Network error";
    }
  }
}