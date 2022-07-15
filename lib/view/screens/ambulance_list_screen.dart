import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../controllers/patient_controller.dart';
import '../../services/map_service.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class AmbulanceListScreen extends StatelessWidget {
  static const String id = 'ambulance_list';
  AmbulanceListScreen({Key? key}) : super(key: key);
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
                  itemCount: controller.ambulances.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        final url = "tel:${controller.ambulances[index].phone}";
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        } else {
                          throw 'Could not open the map.';
                        }
                      },
                      leading: Icon(CupertinoIcons.car_detailed),
                      title: Text(controller.ambulances[index].name),
                      subtitle: Text(controller.ambulances[index].phone),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
