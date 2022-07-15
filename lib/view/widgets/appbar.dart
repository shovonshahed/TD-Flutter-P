import 'package:flutter/material.dart';

import '../screens/doctor_search_delegate.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
      actions: [
        (title == 'Teledoc' || title == 'Doctors')
            ? IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: DoctorSearchDelegate());
                },
                icon: Icon(Icons.search_outlined))
            : SizedBox.shrink()
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
