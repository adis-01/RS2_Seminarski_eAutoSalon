
import 'package:eautosalon_mobile/models/car.dart';
import 'package:eautosalon_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finished_business.g.dart';

@JsonSerializable()
class FinishedBusiness{
  DateTime? datumProdaje;
  Car? automobil;
  User? korisnik;
  double? iznos;

  FinishedBusiness(this.datumProdaje,this.automobil,this.korisnik,this.iznos);


  factory FinishedBusiness.fromJson(Map<String,dynamic> json) => _$FinishedBusinessFromJson(json);

  Map<String,dynamic> toJson() => _$FinishedBusinessToJson(this);
}