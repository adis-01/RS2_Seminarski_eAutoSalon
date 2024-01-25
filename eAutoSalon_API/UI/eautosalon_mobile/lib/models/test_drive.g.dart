// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_drive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestDrives _$TestDrivesFromJson(Map<String, dynamic> json) => TestDrives(
      json['testnaVoznjaId'] as int?,
      json['datumVrijeme'] == null
          ? null
          : DateTime.parse(json['datumVrijeme'] as String),
      json['status'] as String?,
      json['automobil'] == null
          ? null
          : Car.fromJson(json['automobil'] as Map<String, dynamic>),
      json['korisnik'] == null
          ? null
          : User.fromJson(json['korisnik'] as Map<String, dynamic>),
      json['uposlenik'] == null
          ? null
          : Employee.fromJson(json['uposlenik'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestDrivesToJson(TestDrives instance) =>
    <String, dynamic>{
      'testnaVoznjaId': instance.testnaVoznjaId,
      'datumVrijeme': instance.datumVrijeme?.toIso8601String(),
      'status': instance.status,
      'automobil': instance.automobil,
      'korisnik': instance.korisnik,
      'uposlenik': instance.uposlenik,
    };
