import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teledoc/models/index.dart';
import 'package:teledoc/view/screens/profile_edit_screen.dart';
import '../../constants/constants.dart';

import '../../controllers/patient_controller.dart';
import '../widgets/drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profile_screen';
  ProfileScreen({Key? key}) : super(key: key);
  final PatientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final Patient patient = controller.patient;
    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text(
            "Profile",
            style: kAppbarTextStyle.copyWith(color: kColorDarker),
          ),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorDarker,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // margin: EdgeInsets.only(top: 47.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile Information",
                        style: kBodyTextStyle,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ProfileEditScreen.id);
                        },
                        child: Text(
                          "Edit",
                          style: kBodyTextStyle3.copyWith(color: kAccentColor),
                        ),
                      )
                    ],
                  ),
                  ProfileFieldWidget(
                    title: "Name",
                    value: patient.name,
                    icon: CupertinoIcons.profile_circled,
                  ),
                  ProfileFieldWidget(
                    title: "Email",
                    value: patient.email,
                    icon: CupertinoIcons.mail,
                  ),
                  ProfileFieldWidget(
                    title: "Phone Number",
                    value: patient.phoneNumber ?? "",
                    icon: CupertinoIcons.phone,
                  ),
                  ProfileFieldWidget(
                    title: "Gender",
                    value: patient.gender ?? "",
                    icon: CupertinoIcons.square_righthalf_fill,
                  ),
                  ProfileFieldWidget(
                    title: "Date Of Birth",
                    value: patient.dateOfBirth ?? "",
                    icon: CupertinoIcons.calendar,
                  ),
                  ProfileFieldWidget(
                    title: "Address",
                    value: patient.address ?? "",
                    icon: CupertinoIcons.location,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.h),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Change Password",
                        style: kBodyTextStyle3.copyWith(color: kAccentColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }
}

class ProfileFieldWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const ProfileFieldWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kColorLiter,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 20.w,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                title,
                style: kBodyTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.w,
              ),
              Container(
                width: 339.w,
                child: Text(
                  value,
                  style: kBodyTextStyle2.copyWith(color: kColorLite),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
