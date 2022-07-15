import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teledoc/services/loading_service.dart';

import '../../constants/constants.dart';
import '../../controllers/patient_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class FileUploadScreen extends StatefulWidget {
  static const String id = 'file_upload';
  const FileUploadScreen({Key? key}) : super(key: key);

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? file;
  final PatientController controller = Get.find();

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  uploadFile() async {
    CustomDialog.showLoading(msg: "Uploading file...");
    bool upload = await controller.uploadFile(file!);
    if (upload) {
      CustomDialog.dismiss();
      CustomDialog.showToast("File Upload successful!");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Upload files"),
      drawer: SideDrawer(pageName: "file_upload"),
      body: SafeArea(
        child: Column(
          children: [
            (file != null)
                ? Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.file_copy_outlined),
                        title: Text(file!.path.split('/').last),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 300.h, horizontal: 80.w),
                        child: TextButton(
                          onPressed: () => uploadFile(),
                          style: kButtonStyle,
                          child: Text("Upload"),
                        ),
                      )
                    ],
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => pickFile(), child: Icon(Icons.add)),
    );
  }
}
