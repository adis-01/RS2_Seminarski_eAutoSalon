
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{

  String? brojTransakcije;
  String? iznos;
  String? valuta;
  String? tipTransakcije;

  Transaction(this.brojTransakcije,this.iznos,this.valuta,this.tipTransakcije);

  factory Transaction.fromJson(Map<String,dynamic> json) => _$TransactionFromJson(json);

  Map<String,dynamic> toJson() => _$TransactionToJson(this);
}