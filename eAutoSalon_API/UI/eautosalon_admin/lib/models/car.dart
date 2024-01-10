
import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Automobil {
  int? automobilId;
  String? brojSasije;
  String? boja;
  int? godinaProizvodnje;
  String? snagaMotora;
  String? vrstaGoriva;
  int? brojVrata;
  int? predjeniKilometri;
  String? proizvodjac;
  String? model;

  Automobil(
      this.automobilId,
      this.brojSasije,
      this.boja,
      this.godinaProizvodnje,
      this.snagaMotora,
      this.vrstaGoriva,
      this.brojVrata,
      this.predjeniKilometri,
      this.proizvodjac,
      this.model);

  factory Automobil.fromJson(Map<String,dynamic> json) => _$AutomobilFromJson(json);

  Map<String,dynamic> toJson() => _$AutomobilToJson(this);
}


