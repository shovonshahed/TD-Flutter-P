import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../models/index.dart';
import '../services/network_service.dart';

class PatientController extends GetxController {
  // late LoginResponse _loginResponse;
  late Patient _patient;
  late String _token;
  RxBool authenticated = false.obs;

  Patient get patient => _patient;

  Future<bool> updateProfile(Patient patient) async {
    final Either<String, Patient> response =
        await NetworkService.updateProfile(patient, _patient.email, _token);
    bool update = false;
    response.fold((left) {
      update = false;
    }, (right) {
      _patient = right;
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
      _patient = right.dataToReturn;
      authenticated.value = true;
    });
    return authenticated.value;
  }

  Future signup(String name, String email, String password,
      String confirmPassword) async {
    return NetworkService.signup(name, email, password, confirmPassword);
  }

  Future logout() async {
    _token = "";
    _patient = Patient();
    authenticated.value = false;
    return !authenticated.value;
  }
}
