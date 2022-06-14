import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teledoc/view/screens/doctor_profile_screen.dart';
import '../../controllers/patient_controller.dart';

import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  HomeScreen({Key? key}) : super(key: key);
  final PatientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MyCustomAppBar(title: "Teledoc"),
        drawer: SideDrawer(pageName: 'home-page'),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text("Doctors"),
              ),
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
      ),
    );
  }
}
