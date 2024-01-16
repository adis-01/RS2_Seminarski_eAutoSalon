// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      json['komentarId'] as int?,
      json['sadrzaj'] as String?,
      json['korisnik'] == null
          ? null
          : KorisnikKomentar.fromJson(json['korisnik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'komentarId': instance.komentarId,
      'sadrzaj': instance.sadrzaj,
      'korisnik': instance.korisnik,
    };
