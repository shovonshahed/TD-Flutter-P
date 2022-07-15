import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:teledoc/models/doctor.dart';
import 'package:teledoc/services/map_service.dart';

import '../../controllers/patient_controller.dart';
import '../../services/loading_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'doctor_schedules_screen.dart';
import 'home_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final PatientController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: widget.doctor.name,
      ),
      drawer: SideDrawer(
        pageName: 'doctor-profile',
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text("Gender"),
              subtitle: Text(widget.doctor.gender ?? ""),
            ),
            ListTile(
              title: Text("Institute"),
              subtitle: Text(widget.doctor.college ?? ""),
            ),
            ListTile(
              title: Text("Speciality"),
              subtitle: Text(widget.doctor.speciality ?? ""),
            ),
            ListTile(
              title: Text("Address"),
              subtitle: Text(widget.doctor.address ?? ""),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              iconColor: Colors.blue,
              onTap: (widget.doctor.address != null)
                  ? () => MapUtils.openMap(
                      latitude: widget.doctor.mapLocation!.latitude,
                      longitude: widget.doctor.mapLocation!.longitude)
                  : null,
            ),
            ListTile(
              title: Text("Schedules"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              iconColor: Colors.blue,
              tileColor: Colors.blueGrey.shade200,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DoctorSchedulesScreen(doctor: widget.doctor),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
