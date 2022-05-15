import 'package:json_annotation/json_annotation.dart';
import "patient.dart";
part 'loginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse();

  late String token;
  late Patient dataToReturn;
  
  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
