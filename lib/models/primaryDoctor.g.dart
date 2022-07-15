// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primaryDoctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryDoctor _$PrimaryDoctorFromJson(Map<String, dynamic> json) =>
    PrimaryDoctor()
      ..id = json['id'] as num
      ..phone = json['phone'] as String
      ..name = json['name'] as String?;

Map<String, dynamic> _$PrimaryDoctorToJson(PrimaryDoctor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'name': instance.name,
    };
