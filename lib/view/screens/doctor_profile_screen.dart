import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teledoc/models/doctor.dart';

import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'home_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;

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
      appBar: MyCustomAppBar(
        title: doctor.name,
      ),
      drawer: SideDrawer(pageName: 'doctor-profile',),
      body: SafeArea(
        child: Column(
          children: [
            const ListTile(
              title: Text("Schedules"),
            ),
            ListView.builder(
              itemCount: doctor.schedules.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(getDayName(doctor.schedules[index].dayOfWeek)),
                  subtitle: Text(
                      "${DateFormat.jm().format(DateTime.parse(doctor.schedules[index].startTime))} - ${DateFormat.jm().format(DateTime.parse(doctor.schedules[index].endTime))}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
