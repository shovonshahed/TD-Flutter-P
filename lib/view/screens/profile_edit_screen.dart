import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:teledoc/controllers/patient_controller.dart';
import 'package:teledoc/models/index.dart';
import 'package:teledoc/services/loading_service.dart';
import 'package:teledoc/view/screens/profile_screen.dart';
import '../../constants/constants.dart';
import '../widgets/drawer.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String id = 'profile_edit_screen';

  ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final PatientController controller = Get.find();
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  final _formKey = GlobalKey<FormState>();
  DateTime dateOfBirth = DateTime.now();
  String? gender;
  int? genderValue;

  setGenderValue() {
    if (gender == "Male") {
      genderValue = 1;
    } else if (gender == "Female") {
      genderValue = 2;
    } else if (gender == "Transgender") {
      genderValue = 3;
    }
  }

  setGender() {
    if (genderValue == 1) {
      gender = "Male";
    } else if (genderValue == 2) {
      gender = "Female";
    } else if (genderValue == 3) {
      gender = "Transgender";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  initialize() {
    final user = controller.patient;
    nameController = TextEditingController(text: user.name);
    mobileNumberController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: user.email);
    addressController = TextEditingController(text: user.address ?? "");
    gender = user.gender ?? "";
    dateOfBirth = DateTime.tryParse(user.dateOfBirth!) ?? DateTime.now();
    if (dateOfBirth.isBefore(DateTime(1900))) {
      dateOfBirth = DateTime(1900);
    }
    setGenderValue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  void update() async {
    if (_formKey.currentState!.validate()) {
      CustomDialog.showLoading(msg: "Updating Profile...");
      Patient patient = controller.patient;
      patient.name = nameController.text;
      patient.email = emailController.text;
      patient.phoneNumber = mobileNumberController.text;
      patient.address = addressController.text;
      patient.gender = gender;
      patient.dateOfBirth = dateOfBirth.toIso8601String();
      bool update = await controller.updateProfile(patient);
      if (update) {
        CustomDialog.dismiss();
        CustomDialog.showToast("Profile update successful!");
        Navigator.popAndPushNamed(context, ProfileScreen.id);
      } else {
        CustomDialog.dismiss();
        CustomDialog.showToast("Something went wrong. Please try again later.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text(
            "Edit Profile",
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Information",
                          style: kBodyTextStyle,
                        ),
                      ],
                    ),
                    ProfileFieldWidget(
                      title: "Name",
                      controller: nameController,
                      icon: CupertinoIcons.profile_circled,
                    ),
                    ProfileFieldWidget(
                      title: "Email",
                      controller: emailController,
                      icon: CupertinoIcons.mail,
                    ),
                    ProfileFieldWidget(
                      title: "Mobile Number",
                      controller: mobileNumberController,
                      icon: CupertinoIcons.phone,
                    ),

                    ProfileFieldWidget(
                      title: "Address",
                      controller: addressController,
                      icon: CupertinoIcons.mail,
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kColorLiter,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.profile_circled,
                                color: kPrimaryColor,
                                size: 20.w,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                "Gender",
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
                              DropdownButton(
                                key: Key("gender"),
                                value: genderValue,
                                hint: Text("Gender"),
                                items: [
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 1,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 2,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Transgender',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    genderValue = value;
                                    setGender();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: dateOfBirth,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());
                        if (newDate == null) return;
                        setState(() => dateOfBirth = newDate);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kColorLiter,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  color: kPrimaryColor,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Date of Birth",
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
                                  height: 36.w,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "${DateFormat.yMMMMd().format(dateOfBirth)}",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: kColorLite),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ProfileFieldWidget(
                    //   title: "Address",
                    //   value: "House 40, Road 7, Bloc c, Banasree",
                    //   icon: CupertinoIcons.location,
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50.h),
                      child: TextButton(
                        onPressed: () async {
                          update();
                          // await _determinePosition().then((value) {
                          //   print("lat: ${value.latitude}");
                          //   print("long: ${value.longitude}");
                          // });
                        },
                        style: kButtonStyle,
                        child: Text("Save"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}

class ProfileFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;

  const ProfileFieldWidget({
    Key? key,
    required this.title,
    required this.controller,
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
        mainAxisAlignment: MainAxisAlignment.center,
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
                alignment: Alignment.center,
                width: 339.w,
                height: 36.w,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10)),
                  style: TextStyle(fontSize: 14.sp, color: kColorLite),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "strings.fieldValidator";
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
