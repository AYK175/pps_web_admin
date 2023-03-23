import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DashboardName extends StatelessWidget {
  String title;
  DashboardName({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
      child: Container(
          width: 0.8.sw,
          padding: REdgeInsets.only(left: 20.r, top: 10.r, bottom: 10.r),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
