import 'package:hire_stream/models/job.dart';
import 'package:hire_stream/services/api.dart';

class JobProvider{
  List<Job> jobs;
  Future<List<Job>> getJobs() async{
    jobs=await Api().getJobs();
    return jobs;
  }
}