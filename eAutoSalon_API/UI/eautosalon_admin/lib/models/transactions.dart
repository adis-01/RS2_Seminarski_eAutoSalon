
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transactions.g.dart';

@JsonSerializable()
class Transakcija{
  String? brojTransakcije;
  String? iznos;
  String? valuta;

  Transakcija(this.brojTransakcije, this.iznos, this.valuta);

    factory Transakcija.fromJson(Map<String,dynamic> json) => _$TransakcijaFromJson(json);

    Map<String,dynamic> toJson() => _$TransakcijaToJson(this);
}