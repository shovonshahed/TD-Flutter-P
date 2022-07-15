import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teledoc/view/screens/doctors_list_screen.dart';
import 'package:teledoc/view/screens/file_upload_screen.dart';
import 'package:teledoc/view/screens/hospitals_list_screen.dart';
import 'package:teledoc/view/screens/primary_doctors_list_screen.dart';
import '../../services/loading_service.dart';
import '../screens/ambulance_list_screen.dart';
import '../screens/appointments_list_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/welcome_screen.dart';

import '../../constants/constants.dart';
import '../../controllers/patient_controller.dart';
import '../screens/profile_screen.dart';

enum DeviceType { Phone, Tablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
}

class SideDrawer extends StatelessWidget {
  SideDrawer({
    Key? key,
    required this.pageName,
  }) : super(key: key);
  final String pageName;
  final PatientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // print("text scale: ${MediaQuery.of(context).textScaleFactor}");
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Color(0xFF06122A),
            ),
            InkWell(
              onTap: pageName != 'profile-view'
                  ? () {
                      Navigator.pushNamed(context, ProfileScreen.id);
                    }
                  : null,
              child: Container(
                height: 80.w,
                // width: 500.w,
                decoration: BoxDecoration(
                  color: Color(0xFF06122A),
                ),
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Row(
                  children: [
                    Container(
                      width: (getDeviceType() == DeviceType.Tablet)
                          ? 122.w
                          : 220.w,
                      child: Text(
                        controller.patient.value.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != 'home-page'
                  ? () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.id,
                        (route) => false,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != 'profile'
                  ? () => Navigator.pushNamed(
                        context,
                        ProfileScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.account_box_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Doctors",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != DoctorsListScreen.id
                  ? () => Navigator.pushNamed(
                        context,
                        DoctorsListScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.building_2_fill,
                color: Colors.white,
              ),
              title: Text(
                "Hospitals",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != HospitalsListScreen.id
                  ? () => Navigator.pushNamed(
                        context,
                        HospitalsListScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.car_detailed,
                color: Colors.white,
              ),
              title: Text(
                "Ambulance",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != AmbulanceListScreen.id
                  ? () => Navigator.pushNamed(
                        context,
                        AmbulanceListScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              title: Text(
                "Primary Counsil",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != PrimaryDoctorsListScreen.id
                  ? () => Navigator.pushNamed(
                        context,
                        PrimaryDoctorsListScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.input,
                color: Colors.white,
              ),
              title: Text(
                "My Appointments",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != 'appintments-page'
                  ? () => Navigator.pushNamed(
                        context,
                        AppointmentsListScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.input,
                color: Colors.white,
              ),
              title: Text(
                "Upload My Files",
                style: TextStyle(color: Colors.white),
              ),
              onTap: pageName != 'file-upload'
                  ? () => Navigator.pushNamed(
                        context,
                        FileUploadScreen.id,
                      )
                  : null,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                CustomDialog.showLoading(msg: "Logging Out");
                bool logout = await controller.logout();
                if (logout) {
                  CustomDialog.dismiss();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
