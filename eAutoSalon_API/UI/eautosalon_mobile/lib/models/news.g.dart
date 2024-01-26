// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      json['novostiId'] as int?,
      json['tip'] as String?,
      json['naslov'] as String?,
      json['sadrzaj'] as String?,
      json['datumObjave'] == null
          ? null
          : DateTime.parse(json['datumObjave'] as String),
      json['slika'] as String?,
      json['korisnik'] == null
          ? null
          : KorisnikClanak.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'novostiId': instance.novostiId,
      'tip': instance.tip,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'slika': instance.slika,
      'datumObjave': instance.datumObjave?.toIso8601String(),
      'korisnik': instance.korisnik,
    };
