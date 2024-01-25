// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      json['automobilId'] as int?,
      json['brojSasije'] as String?,
      json['boja'] as String?,
      json['godinaProizvodnje'] as int?,
      json['snagaMotora'] as String?,
      json['vrstaGoriva'] as String?,
      json['brojVrata'] as int?,
      json['predjeniKilometri'] as int?,
      json['proizvodjac'] as String?,
      json['model'] as String?,
      json['slika'] as String?,
      (json['cijena'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'automobilId': instance.automobilId,
      'brojSasije': instance.brojSasije,
      'boja': instance.boja,
      'godinaProizvodnje': instance.godinaProizvodnje,
      'snagaMotora': instance.snagaMotora,
      'vrstaGoriva': instance.vrstaGoriva,
      'brojVrata': instance.brojVrata,
      'predjeniKilometri': instance.predjeniKilometri,
      'proizvodjac': instance.proizvodjac,
      'model': instance.model,
      'slika': instance.slika,
      'cijena': instance.cijena,
    };
