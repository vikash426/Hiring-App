class Employee{
  String id,name,email,password,number,description;
  int jobId,rate,review;

  Employee({this.id,this.name,this.email,this.password,this.description,this.jobId,this.number,this.rate,this.review});
  factory Employee.fromJson(Map<String, dynamic> json)
  {
    print(json);
    return Employee(
      id:json['_id'] as String,
    jobId:json['emp_id'] as int,
    name:json['emp_name'] as String,
    email:json['emp_email'] as String,
    password:json['emp_password'] as String,
    number:json['emp_number'] as String,
    description:json['emp_description'] as String,
    rate:json['rate'] as int,
    review:json['review']==null?0:json['review'] as int
    );
  } 
}