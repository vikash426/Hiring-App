
class Job{
  int id;
  String jobName;

  Job({this.id,this.jobName});

  factory Job.fromJson(Map<String,dynamic> json){
    return Job(
      id: json['job_id'] as int,
      jobName: json['job_name'] as String
      );
  }
}