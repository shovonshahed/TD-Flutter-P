import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teledoc/models/ambulance.dart';
import 'package:teledoc/models/doctor.dart';
import 'package:teledoc/models/hospital.dart';
import 'package:teledoc/models/primaryDoctor.dart';

import '../models/index.dart';
import '../models/schedule.dart';

class NetworkService {
  static const url = "https://teledoc.azurewebsites.net";
  // static const url = "http://10.0.2.2:5073";
  // static const url = "10.0.2.2:7116";

  static Future uploadFile(File file, String token) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response =
          await dio.post(url + '/api/patients/prescription', data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
      // throw e;
    }
  }

  static Future<Either<String, List<Schedule>>> getMyAppointments(
      String token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        url + '/api/patients/appoinment',
      );
      print(response.data);
      if (response.statusCode == 200) {
        // Schedule schedule = Schedule.fromJson(response.data);
        List<dynamic> schedulesMap = response.data;
        List<Schedule> schedules = [];
        schedules = (schedulesMap)
            .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(schedules);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, List<Hospital>>> getHospitals(
      String token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        url + '/api/admin/hospital',
      );
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> hospitalMap = response.data;
        List<Hospital> hospitals = [];
        hospitals = (hospitalMap)
            .map((e) => Hospital.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(hospitals);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, List<PrimaryDoctor>>> getPrimaryDoctors(
      String token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        url + '/api/admin/primary',
      );
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> doctorsMap = response.data;
        List<PrimaryDoctor> hospitals = [];
        hospitals = (doctorsMap)
            .map((e) => PrimaryDoctor.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(hospitals);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, List<Ambulance>>> getAmbulances(
      String token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        url + '/api/admin/ambulance',
      );
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> doctorsMap = response.data;
        List<Ambulance> hospitals = [];
        hospitals = (doctorsMap)
            .map((e) => Ambulance.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(hospitals);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, List<Doctor>>> getDoctors(String token) async {
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.get(
        url + '/api/doctors',
      );
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> doctorsMap = response.data;
        List<Doctor> doctors = [];
        doctors = (doctorsMap)
            .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(doctors);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, List<Doctor>>> getDoctorsByName(
      String token, String keyWord) async {
    try {
      Map<String, dynamic> parameters = {
        "name": keyWord,
      };
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response =
          await dio.get(url + '/api/doctors/dn', queryParameters: parameters);
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> doctorsMap = response.data;
        List<Doctor> doctors = [];
        doctors = (doctorsMap)
            .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(doctors);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

  static Future<Either<String, Schedule>> bookSchedule(
      String email, String dayOfWeek, String token) async {
    Map<String, dynamic> parameters = {
      "email": email,
      "dayOfWeek": dayOfWeek,
    };
    try {
      Dio dio = new Dio();
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Authorization"] = "Bearer ${token}";
      var response = await dio.post(url + '/api/doctors/booking',
          queryParameters: parameters);
      print(response.data);
      if (response.statusCode == 200) {
        // Map<String, dynamic> userMap = jsonDecode(response.body);
        Schedule schedule = Schedule.fromJson(response.data);
        return Right(schedule);
      } else {
        return const Left("Some error occurred.");
      }
    } catch (e) {
      print(e);
      return const Left("Some error occurred.");
      // throw e;
    }
  }

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
