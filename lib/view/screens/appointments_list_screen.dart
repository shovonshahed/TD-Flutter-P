import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../../controllers/patient_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class AppointmentsListScreen extends StatelessWidget {
  static const String id = 'appointments';
  AppointmentsListScreen({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "My Appointments"),
      drawer: SideDrawer(pageName: 'appintments-page'),
      body: SafeArea(
        child: ListView.builder(
          itemCount: controller.schedules.value.length,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.access_time),
            title:
                Text(getDayName(controller.schedules.value[index].dayOfWeek)),
            subtitle: Text(
                "${DateFormat.jm().format(DateTime.parse(controller.schedules.value[index].startTime))} - ${DateFormat.jm().format(DateTime.parse(controller.schedules.value[index].endTime))}"),
          ),
        ),
      ),
    );
  }
}
