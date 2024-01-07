
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee{
  int? uposlenikId;
  String? firstName;
  String? lastName;
  String? kontakt;
  String? title;
  String? slika;

  Employee(this.uposlenikId, this.firstName, this.lastName, this.kontakt, this.title, this.slika);

  factory Employee.fromJson(Map<String,dynamic> json) => _$EmployeeFromJson(json);

  Map<String,dynamic> toJson() => _$EmployeeToJson(this);

}