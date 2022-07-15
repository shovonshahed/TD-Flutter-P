// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambulance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ambulance _$AmbulanceFromJson(Map<String, dynamic> json) => Ambulance()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..phone = json['phone'] as String
  ..details = json['details'] as String?;

Map<String, dynamic> _$AmbulanceToJson(Ambulance instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'details': instance.details,
    };
