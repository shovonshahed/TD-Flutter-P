import 'package:json_annotation/json_annotation.dart';

part 'primaryDoctor.g.dart';

@JsonSerializable()
class PrimaryDoctor {
  PrimaryDoctor();

  late num id;
  late String phone;
  String? name;
  
  factory PrimaryDoctor.fromJson(Map<String,dynamic> json) => _$PrimaryDoctorFromJson(json);
  Map<String, dynamic> toJson() => _$PrimaryDoctorToJson(this);
}
