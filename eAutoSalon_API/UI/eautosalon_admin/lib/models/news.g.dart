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
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'novostiId': instance.novostiId,
      'tip': instance.tip,
      'naslov': instance.naslov,
      'sadrzaj': instance.sadrzaj,
      'datumObjave': instance.datumObjave?.toIso8601String(),
    };
