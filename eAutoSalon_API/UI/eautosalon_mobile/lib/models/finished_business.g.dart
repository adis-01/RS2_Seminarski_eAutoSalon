// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finished_business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinishedBusiness _$FinishedBusinessFromJson(Map<String, dynamic> json) =>
    FinishedBusiness(
      json['datumProdaje'] == null
          ? null
          : DateTime.parse(json['datumProdaje'] as String),
      json['automobil'] == null
          ? null
          : Car.fromJson(json['automobil'] as Map<String, dynamic>),
      json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      (json['iznos'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FinishedBusinessToJson(FinishedBusiness instance) =>
    <String, dynamic>{
      'datumProdaje': instance.datumProdaje?.toIso8601String(),
      'automobil': instance.automobil,
      'korisnik': instance.korisnik,
      'iznos': instance.iznos,
    };
