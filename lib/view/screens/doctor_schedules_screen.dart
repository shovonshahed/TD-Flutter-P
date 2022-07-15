import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../controllers/patient_controller.dart';
import '../../models/doctor.dart';
import '../../services/loading_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class DoctorSchedulesScreen extends StatefulWidget {
  DoctorSchedulesScreen({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;

  @override
  State<DoctorSchedulesScreen> createState() => _DoctorSchedulesScreenState();
}

class _DoctorSchedulesScreenState extends State<DoctorSchedulesScreen> {
  final PatientController controller = Get.find();

  bool isLoading = false;

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
                // Aamarpay(
                //   // This will return a payment url based on failUrl,cancelUrl,successUrl
                //   returnUrl: (String url) {
                //     print(url);
                //   },
                //   // This will return the payment loading status
                //   isLoading: (bool loading) {
                //     setState(() {
                //       isLoading = loading;
                //     });
                //   },
                //   // This will return the payment status
                //   paymentStatus: (String status) {
                //     print(status);
                //   },
                //   // This will return the payment event with a message
                //   status: (EventState event, String message) {
                //     if (event == EventState.error) {
                //       setState(() {
                //         isLoading = false;
                //       });
                //     }
                //   },
                //   // When you use your own url, you must have the keywords:cancel,confirm,fail otherwise the callback function will not work properly
                //   cancelUrl: "example.com/payment/cancel",
                //   successUrl: "example.com/payment/confirm",
                //   failUrl: "example.com/payment/fail",
                //   customerEmail: "masumbillahsanjid@gmail.com",
                //   customerMobile: "01834760591",
                //   customerName: "Masum Billah Sanjid",
                //   // That is the test signature key. But when you go to the production you must use your own signature key
                //   signature: "dbb74894e82415a2f7ff0ec3a97e4183",
                //   // That is the test storeID. But when you go to the production you must use your own storeID
                //   storeID: "aamarpaytest",
                //   transactionAmount: "100",
                //   //The transactionID must be unique for every payment
                //   transactionID: "transactionID",
                //   description: "test",
                //   // When the application goes to the producation the isSandbox must be false
                //   isSandBox: true,
                //   child: isLoading
                //       ? Center(
                //           child: CircularProgressIndicator(),
                //         )
                //       : Container(
                //           color: Colors.orange,
                //           height: 50,
                //           child: Center(
                //             child: Text(
                //               "Payment",
                //               style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             ),
                //           ),
                //         ),
                // ),
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
