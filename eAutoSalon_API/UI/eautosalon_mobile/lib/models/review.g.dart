// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['recenzijaId'] as int?,
      json['ocjena'] as int?,
      json['komentar'] as String?,
      json['korisnik'] == null
          ? null
          : UserReview.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'recenzijaId': instance.recenzijaId,
      'ocjena': instance.ocjena,
      'komentar': instance.komentar,
      'korisnik': instance.korisnik,
    };
