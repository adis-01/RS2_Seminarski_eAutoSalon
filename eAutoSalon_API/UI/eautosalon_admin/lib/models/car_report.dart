
import 'package:json_annotation/json_annotation.dart';
part 'car_report.g.dart';

@JsonSerializable()
class ReportCar{
  String? brojSasije;
  String? proizvodjac;
  String? model;

  ReportCar(this.brojSasije,this.proizvodjac,this.model);

  factory ReportCar.fromJson(Map<String,dynamic> json) => _$ReportCarFromJson(json);

  Map<String,dynamic> toJson() => _$ReportCarToJson(this);

}