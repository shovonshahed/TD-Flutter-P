// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..phone = json['phone'] as String
  ..details = json['details'] as String?
  ..location = MapLocation.fromJson(json['location'] as Map<String, dynamic>);

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'details': instance.details,
      'location': instance.location,
    };
