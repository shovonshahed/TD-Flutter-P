import 'package:json_annotation/json_annotation.dart';

part 'ambulance.g.dart';

@JsonSerializable()
class Ambulance {
  Ambulance();

  late num id;
  late String name;
  late String phone;
  String? details;
  
  factory Ambulance.fromJson(Map<String,dynamic> json) => _$AmbulanceFromJson(json);
  Map<String, dynamic> toJson() => _$AmbulanceToJson(this);
}
