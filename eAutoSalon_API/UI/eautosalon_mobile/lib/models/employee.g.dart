// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      json['uposlenikId'] as int?,
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['kontakt'] as String?,
      json['title'] as String?,
      json['slika'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'uposlenikId': instance.uposlenikId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'kontakt': instance.kontakt,
      'title': instance.title,
      'slika': instance.slika,
    };
