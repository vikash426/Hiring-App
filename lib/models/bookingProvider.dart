import 'package:hire_stream/models/booking.dart';

import 'package:hire_stream/services/api.dart';


class BookingProvider{
  List<Booking> jobs;
  Future<List<Booking>> getBookings(String empId) async{
    if(Api.currentUserType=="employee")
    jobs=await Api().getBookings(empId);
    else
    jobs=await Api().getBookingsCust(empId);
    
    return jobs;
  }
}