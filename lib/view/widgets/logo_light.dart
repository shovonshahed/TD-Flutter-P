import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoLight extends StatelessWidget {
  const LogoLight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 90.h,
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 23.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF000000).withOpacity(0.1),
              offset: Offset.fromDirection(1.r, 5.r),
              blurRadius: 5.r,
              spreadRadius: 1.r),
        ],
      ),
      child: Image(
        image: AssetImage('assets/images/logo/logo.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}
