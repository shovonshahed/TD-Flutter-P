import 'package:json_annotation/json_annotation.dart';
import "mapLocation.dart";
part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  Hospital();

  late num id;
  late String name;
  late String phone;
  String? details;
  late MapLocation location;
  
  factory Hospital.fromJson(Map<String,dynamic> json) => _$HospitalFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}
