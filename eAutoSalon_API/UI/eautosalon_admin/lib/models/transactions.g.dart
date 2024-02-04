// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transakcija _$TransakcijaFromJson(Map<String, dynamic> json) => Transakcija(
      json['brojTransakcije'] as String?,
      json['iznos'] as String?,
      json['valuta'] as String?,
    );

Map<String, dynamic> _$TransakcijaToJson(Transakcija instance) =>
    <String, dynamic>{
      'brojTransakcije': instance.brojTransakcije,
      'iznos': instance.iznos,
      'valuta': instance.valuta,
    };
