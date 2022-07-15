import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/patient_controller.dart';
import '../../services/map_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class HospitalsListScreen extends StatelessWidget {
  static const String id = 'Hospitals_list';
  HospitalsListScreen({Key? key}) : super(key: key);
  final PatientController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Hospitals"),
      drawer: SideDrawer(pageName: id),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  itemCount: controller.hospitals.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => MapUtils.openMap(
                          latitude:
                              controller.hospitals[index].location.latitude,
                          longitude:
                              controller.hospitals[index].location.longitude),
                      leading: Icon(CupertinoIcons.building_2_fill),
                      title: Text(controller.hospitals[index].name),
                      subtitle: Text(controller.hospitals[index].details ?? ""),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      iconColor: Colors.blue,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
