import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pps_web_admin/constants.dart';
import '../../../shared/app_responsive/app_responsive.dart';
import '../../../shared/components/components.dart';
import '../../../shared/style/color.dart';
import 'notification_content.dart';

class HomePageBodyContentNew extends StatelessWidget {
  const HomePageBodyContentNew({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Align(
        alignment: Alignment.topLeft,

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CalendarWidget(),
             ],
          ),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
     /* decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.darkColor,
      ),
     */ child: Row(
        children: [
          _statsCard(
              label: 'Available Users',
              value: '${userCount} Users',
              icon: Icon(
                Icons.supervised_user_circle_sharp,
                size: 50,
                color: ColorManager.orangeColor,
              )),
          _statsCard(
              label: 'Available Doctors',
              value: '${vetCount} Doctors',
              icon: Icon(
                Icons.monitor_heart_outlined,
                size: 50,
                color: ColorManager.orangeColor,
              )),
          _statsCard(
              label: 'Total Clinics',
              value: '${clinicCount} Clinics',
              icon: Icon(
                Icons.local_hospital,
                size: 50,
                color: ColorManager.orangeColor,
              )),
          _statsCard(
              label: 'Upcoming Bookings',
              value: '${bookingList.length} Bookings',
              icon: Icon(
                Icons.book_online,
                size: 50,
                color: ColorManager.orangeColor,
              )),
        ],
      ),
    );
  }
}
Widget _statsCard(
    {required String label,
      required String value,
      required Widget icon}) =>
    Card(
        color: ColorManager.darkColor,
        elevation: 8.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 255,
          height: 85,
          child: Center(
            child: ListTile(
              leading: icon,
              title: Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: ColorManager.white,
                ),
              ),
              subtitle: Text(
                label,
                style: TextStyle(fontSize: 18,color: ColorManager.orangeColor),
              ),
            ),
          ),
        ));





