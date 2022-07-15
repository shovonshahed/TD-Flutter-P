import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:teledoc/view/screens/ambulance_list_screen.dart';
import 'package:teledoc/view/screens/appointments_list_screen.dart';
import 'package:teledoc/view/screens/doctors_list_screen.dart';
import 'package:teledoc/view/screens/file_upload_screen.dart';
import 'package:teledoc/view/screens/hospitals_list_screen.dart';
import 'package:teledoc/view/screens/primary_doctors_list_screen.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/login_screen.dart';
import 'view/screens/profile_edit_screen.dart';
import 'view/screens/profile_screen.dart';
import 'view/screens/register_screen.dart';
import 'view/screens/welcome_screen.dart';

void main() {
  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(411, 823),
      builder: (context) => MaterialApp(
        title: 'TeleDoc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ProfileEditScreen.id: (context) => ProfileEditScreen(),
          DoctorsListScreen.id: (context) => DoctorsListScreen(),
          AppointmentsListScreen.id: (context) => AppointmentsListScreen(),
          HospitalsListScreen.id: (context) => HospitalsListScreen(),
          AmbulanceListScreen.id: (context) => AmbulanceListScreen(),
          PrimaryDoctorsListScreen.id: (context) => PrimaryDoctorsListScreen(),
          FileUploadScreen.id: (context) => FileUploadScreen(),
        },
        // here
        navigatorObservers: [FlutterSmartDialog.observer],
        // here
        builder: FlutterSmartDialog.init(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
