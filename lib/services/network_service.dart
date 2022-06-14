import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/index.dart';

class NetworkService {
  static const url = "http://10.0.2.2:5073";
  // static const url = "10.0.2.2:7116";

  static Future<Either<String, Patient>> updateProfile(
      Patient patient, String email, String token) async {
    Map<String, dynamic> parameters = {
      "email": email,
    };
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.put(url + '/api/patients/update',
          queryParameters: parameters, data: jsonEncode(patient));
      print(response.data);
      if (response.statusCode == 200) {
        // Map<String, dynamic> userMap = jsonDecode(response.body);
        Patient patient = Patient.fromJson(response.data);
        return Right(patient);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, LoginResponse>> login(
      String email, String password) async {
    Map<String, dynamic> parameters = {"email": email, "password": password};

    try {
      var response = await Dio()
          .post(url + '/api/patients/login', data: jsonEncode(parameters));
      // var uri = Uri.http('$url', '/api/patients/login');
      // var response = await http.post(
      //   uri,
      //   body: jsonEncode(parameters),
      //   headers: {
      //     HttpHeaders.contentTypeHeader: 'application/json',
      //   },
      // );
      print(response.data);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        // Map<String, dynamic> userMap = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        // return const Left("Some error occurred.");
        return Right(loginResponse);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<bool> signup(String name, String email, String password,
      String confirmPassword) async {
    Map<String, dynamic> parameters = {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword
    };

    try {
      // var response = await http.post(Uri.http(url, LOGIN_ROUTE),body: parameters);
      var response = await Dio()
          .post(url + '/api/patients/register', data: jsonEncode(parameters));
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 500) {
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      // throw e;
      return false;
    }
  }
}
