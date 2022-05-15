import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  Patient();

  late String userName;
  late String name;
  late String email;
  late String gender;
  late String dateOfBirth;
  late String address;
  late String phoneNumber;
  late String disease;
  late List prescriptions;
  
  factory Patient.fromJson(Map<String,dynamic> json) => _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
