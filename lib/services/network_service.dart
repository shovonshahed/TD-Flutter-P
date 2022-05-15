import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:teledoc/models/index.dart';

import '../constants/strings.dart';

class NetworkService {
  static const url = "http://10.0.2.2:5073";

  static Future login(String email, String password) async {

    Map<String, dynamic> parameters = {
      "email": email,
      "password": password
    };

    try {
      // var response = await http.post(Uri.http(url, LOGIN_ROUTE),body: parameters);
      var response = await Dio().post(url+'/api/patients/login',data: jsonEncode(parameters));
      // Map<String,dynamic> loginMap = jsonDecode(response.data);
      // var response = await Dio().get(url);
      // LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.data));
      // print(loginResponse.dataToReturn);
      // print(response.data);
      if(response.statusCode == 200){
        return true;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
  static Future signup(String name,String email, String password,String confirmPassword) async {

    Map<String, dynamic> parameters = {
      "name": name,
      "email":email,
      "password": password,
      "confirmPassword": confirmPassword
    };

    try {
      // var response = await http.post(Uri.http(url, LOGIN_ROUTE),body: parameters);
      var response = await Dio().post(url+'/api/patients/register',data: jsonEncode(parameters));
      // Map<String,dynamic> loginMap = jsonDecode(response.data);
      // var response = await Dio().get(url);
      // LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(response.data));
      // print(loginResponse.dataToReturn);
      // print(response.data);
      if(response.statusCode == 200){
        return true;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}