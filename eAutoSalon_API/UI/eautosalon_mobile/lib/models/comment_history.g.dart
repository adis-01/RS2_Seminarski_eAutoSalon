// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KomentarHistorija _$KomentarHistorijaFromJson(Map<String, dynamic> json) =>
    KomentarHistorija(
      json['sadrzaj'] as String?,
      json['novosti'] == null
          ? null
          : ClanakHistorija.fromJson(json['novosti'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KomentarHistorijaToJson(KomentarHistorija instance) =>
    <String, dynamic>{
      'sadrzaj': instance.sadrzaj,
      'novosti': instance.novosti,
    };
