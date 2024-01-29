// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      json['brojTransakcije'] as String?,
      json['iznos'] as String?,
      json['valuta'] as String?,
      json['tipTransakcije'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'brojTransakcije': instance.brojTransakcije,
      'iznos': instance.iznos,
      'valuta': instance.valuta,
      'tipTransakcije': instance.tipTransakcije,
    };
