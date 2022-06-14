import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teledoc/models/doctor.dart';
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
  RxBool authenticated = false.obs;

  // Patient get patient => _patient;

  Future getDoctors() async {
    final Either<String, List<Doctor>> response =
        await NetworkService.getDoctors(_token);
    response.fold((left) {
      CustomDialog.showToast("Doctors loading failed");
    }, (right) {
      doctors.value = right;
      print("Doctor Name: ${doctors.elementAt(1).name}");
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
