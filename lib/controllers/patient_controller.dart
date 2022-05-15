import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledoc/models/index.dart';
import 'package:teledoc/services/network_service.dart';



class PatientController extends GetxController {
  // late LoginResponse _loginResponse;
  late Patient _patient;
  late String _token;

  Patient get ()=> _patient;
  
  Future login(String email, String password) async{
    return NetworkService.login(email, password);
  }

  Future signup(String name,String email, String password,String confirmPassword) async{
    return NetworkService.signup(name,email,password,confirmPassword);
  }
}