import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:teledoc/models/doctor.dart';

import '../../controllers/patient_controller.dart';
import '../../services/loading_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'home_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final PatientController controller = Get.find();

  String getDayName(num dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return "Saturday";
      case 2:
        return "Sunday";
      case 3:
        return "Monday";
      case 4:
        return "Tuesday";
      case 5:
        return "Wednesday";
      case 6:
        return "Thursday";
      case 7:
        return "Friday";
      default:
        return "";
    }
  }

  showBookDialog(int index) async {
    String? action = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Book Schedule'),
              content: Text(
                  'Do you want to book an appointment on ${getDayName(widget.doctor.schedules[index].dayOfWeek)} at ${DateFormat.jm().format(DateTime.parse(widget.doctor.schedules[index].startTime))}?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
    if (action == 'OK') {
      bookSchedule(index);
    }
  }

  bookSchedule(int index) async {
    CustomDialog.showLoading(msg: "Booking appointment...");
    bool save = await controller.bookSchedule(
        widget.doctor.email, widget.doctor.schedules[index].dayOfWeek);
    if (save) {
      CustomDialog.dismiss();
      CustomDialog.showToast("Appointment Booked Successfully!");
      Navigator.pop(context);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast("Something went wrong. Please try again later.");
    }
  }

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
            const ListTile(
              title: Text("Schedules"),
            ),
            ListView.builder(
              itemCount: widget.doctor.schedules.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                      getDayName(widget.doctor.schedules[index].dayOfWeek)),
                  subtitle: Text(
                      "${DateFormat.jm().format(DateTime.parse(widget.doctor.schedules[index].startTime))} - ${DateFormat.jm().format(DateTime.parse(widget.doctor.schedules[index].endTime))}"),
                  onTap: () => showBookDialog(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
