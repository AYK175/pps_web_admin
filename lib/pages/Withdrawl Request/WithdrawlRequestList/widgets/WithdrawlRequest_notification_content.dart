import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WithdrawlRequestNotificationContent extends StatelessWidget {
  const WithdrawlRequestNotificationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 10),
      child: SingleChildScrollView(
        physics: (!AppResponsive.isDesktop(context)) ?const NeverScrollableScrollPhysics() :const BouncingScrollPhysics() ,
        child: Column(
          children: const [
            CalendarWidget(),
            SizedBox(height: 10),
            TasksWidget(),
          ],
        ),
      ),
    );
  }
}

//calendar
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.darkColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                DateFormat("MMM, yyyy").format(_selectedDate),
                style: const TextStyle(
                  color: ColorManager.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  _selectedDate =
                      DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
                  setState(() {});
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorManager.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  _selectedDate =
                      DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
                  setState(() {});
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: ColorManager.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          const SizedBox(height: 10),
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
              label: 'Total Bookings',
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

//tasks
class TasksWidget extends StatelessWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.darkColor,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 15,
            /*leading: const CircleAvatar(
              backgroundColor: ColorManager.orangeColor,
              child: Icon(
                Icons.person,
                color: ColorManager.white,
              ),
            ),
            */title:  Center(child: Text("Best Rated Doctors",style: TextStyle(color: ColorManager.white,fontWeight: FontWeight.bold,fontSize: 20))),
            //subtitle: const Text('Developer', style: TextStyle(color: Colors.grey)),
            onTap: () {},
          ),
          myDivider(),
          //task list
          const SizedBox(height: 10),
          vetList.length>0?ListView.separated(
            shrinkWrap: true,
            itemCount: vetList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  taskWidget(
                    Image: vetList[index].profileImg.toString(),
                    title: vetList[index].name.toString(),
                    subtitle: vetList[index].email.toString(),
                    onTap: () {},
                  ),
                  const SizedBox(height: 5),

                ],
              );
            },
            separatorBuilder: (BuildContext context, int index)=> const SizedBox(height: 5),
          ):Center(child: CircularProgressIndicator(),),


        ],
      ),
    );
  }

}

Widget taskWidget({required String Image,required String title, required String subtitle, required Null Function() onTap}) {
  return Card(
    color: ColorManager.lightDarkColor,
    elevation: 8.0,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

    child: SizedBox(
      width: 255,
      height: 85,

      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:7,bottom:5,left:4,),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:2.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Image),
                          fit: BoxFit.cover
                      ),
                      shape: BoxShape.circle
                  ),
                ),
              ),
SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Column(
                  children: [
                    Text(title, style: const TextStyle(color: ColorManager.white)),
                    Text(subtitle, style: const TextStyle(color: ColorManager.orangeColor)),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget _statsCard(
    {required String label,
      required String value,
      required Widget icon}) =>
    Card(
        color: ColorManager.lightDarkColor,
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

