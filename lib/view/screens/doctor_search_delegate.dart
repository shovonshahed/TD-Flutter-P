import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/patient_controller.dart';
import '../../models/doctor.dart';
import 'doctor_profile_screen.dart';

class DoctorSearchDelegate extends SearchDelegate {
  final PatientController controller = Get.find();
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        query = '';
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center();

  @override
  buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      controller.getDoctorsByName(query);
    } else {
      controller.getDoctors();
    }

    List<Doctor> doctors = controller.doctors;
    return ListView.builder(
      itemCount: doctors.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DoctorProfileScreen(doctor: doctors[index]),
              )),
          leading: Icon(CupertinoIcons.profile_circled),
          title: Text(doctors[index].name),
          subtitle: Text(doctors[index].speciality ?? ""),
        );
      },
    );
  }
}
