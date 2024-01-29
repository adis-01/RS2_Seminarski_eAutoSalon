// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDto _$ReportDtoFromJson(Map<String, dynamic> json) => ReportDto(
      json['datumProdaje'] == null
          ? null
          : DateTime.parse(json['datumProdaje'] as String),
      (json['iznos'] as num?)?.toDouble(),
      json['korisnik'] == null
          ? null
          : KorisnikKomentar.fromJson(json['korisnik'] as Map<String, dynamic>),
      json['automobil'] == null
          ? null
          : ReportCar.fromJson(json['automobil'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportDtoToJson(ReportDto instance) => <String, dynamic>{
      'datumProdaje': instance.datumProdaje?.toIso8601String(),
      'iznos': instance.iznos,
      'korisnik': instance.korisnik,
      'automobil': instance.automobil,
    };
