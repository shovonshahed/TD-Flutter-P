import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teledoc/models/ambulance.dart';
import 'package:teledoc/models/doctor.dart';
import 'package:teledoc/models/hospital.dart';
import 'package:teledoc/models/primaryDoctor.dart';
import 'package:teledoc/models/schedule.dart';
import 'package:teledoc/services/loading_service.dart';
import '../models/index.dart';
import '../services/network_service.dart';

class PatientController extends GetxController {
  // late LoginResponse _loginResponse;
  // late Patient _patient;
  var patient = Patient().obs;
  late String _token;
  // List<Doctor> doctors = [];
  var doctors = <Doctor>[].obs;
  var schedules = <Schedule>[].obs;
  var hospitals = <Hospital>[].obs;
  var primaryDoctors = <PrimaryDoctor>[].obs;
  var ambulances = <Ambulance>[].obs;
  RxBool authenticated = false.obs;

  // Patient get patient => _patient;

  Future uploadFile(File file) async {
    return NetworkService.uploadFile(file, _token);
  }

  Future getAmbulances() async {
    final Either<String, List<Ambulance>> response =
        await NetworkService.getAmbulances(_token);
    response.fold((left) {
      CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      ambulances.value = right;
      if (ambulances.value.isNotEmpty)
        print("ambulance Name: ${ambulances.elementAt(1).name}");
    });
    notifyChildrens();
  }

  Future getPrimaryDoctors() async {
    final Either<String, List<PrimaryDoctor>> response =
        await NetworkService.getPrimaryDoctors(_token);
    response.fold((left) {
      CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      primaryDoctors.value = right;
      if (primaryDoctors.value.isNotEmpty)
        print("Doctor Name: ${primaryDoctors.value.elementAt(1).name}");
    });
    notifyChildrens();
  }

  Future getHospitals() async {
    final Either<String, List<Hospital>> response =
        await NetworkService.getHospitals(_token);
    response.fold((left) {
      CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      hospitals.value = right;
      if (hospitals.value.isNotEmpty)
        print("Hospital Name: ${hospitals.value.first.name}");
    });
    notifyChildrens();
  }

  Future getMyAppointments() async {
    final Either<String, List<Schedule>> response =
        await NetworkService.getMyAppointments(_token);
    response.fold((left) {
      CustomDialog.showToast("Appointments loading failed");
    }, (right) {
      schedules.value = right;
      if (schedules.value.isNotEmpty)
        print("Appointment Name: ${schedules.value.first.dayOfWeek}");
    });
    notifyChildrens();
  }

  Future getDoctors() async {
    final Either<String, List<Doctor>> response =
        await NetworkService.getDoctors(_token);
    response.fold((left) {
      CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      doctors.value = right;
      if (doctors.value.isNotEmpty)
        print("Doctor Name: ${doctors.elementAt(1).name}");
    });
    notifyChildrens();
  }

  Future getDoctorsByName(String keyWord) async {
    final Either<String, List<Doctor>> response =
        await NetworkService.getDoctorsByName(_token, keyWord);
    response.fold((left) {
      // CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      doctors.value = right;
    });
    notifyChildrens();
  }

  Future<bool> bookSchedule(String email, num dayOfWeek) async {
    final Either<String, Schedule> response =
        await NetworkService.bookSchedule(email, dayOfWeek.toString(), _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      update = !update;
      getMyAppointments();
    });
    return update;
  }

  Future<bool> updateProfile(Patient tempPatient) async {
    final Either<String, Patient> response = await NetworkService.updateProfile(
        tempPatient, tempPatient.email, _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      patient.value = right;
      notifyChildrens();
      update = !update;
    });
    return update;
  }

  Future login(String email, String password) async {
    final Either<String, LoginResponse> response =
        await NetworkService.login(email, password);
    response.fold((left) {
      authenticated.value = false;
    }, (right) {
      _token = right.token;
      // _patient = right.dataToReturn;
      patient.value = right.dataToReturn;
      authenticated.value = true;
      getDoctors();
      getMyAppointments();
      getHospitals();
      getPrimaryDoctors();
      getAmbulances();
    });
    return authenticated.value;
  }

  Future signup(String name, String email, String password,
      String confirmPassword) async {
    return NetworkService.signup(name, email, password, confirmPassword);
  }

  Future logout() async {
    _token = "";
    // _patient = Patient();
    patient.value = Patient();
    authenticated.value = false;
    return !authenticated.value;
  }
}
