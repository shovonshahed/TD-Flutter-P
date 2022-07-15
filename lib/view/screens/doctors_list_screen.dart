import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/patient_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'doctor_profile_screen.dart';

class DoctorsListScreen extends StatelessWidget {
  static const String id = 'doctors_list';
  DoctorsListScreen({Key? key}) : super(key: key);
  final PatientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Doctors"),
      drawer: SideDrawer(pageName: id),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  itemCount: controller.doctors.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorProfileScreen(
                                doctor: controller.doctors[index]),
                          )),
                      leading: Icon(CupertinoIcons.profile_circled),
                      title: Text(controller.doctors[index].name),
                      subtitle:
                          Text(controller.doctors[index].speciality ?? ""),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
