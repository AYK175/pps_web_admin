import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../constants.dart';
import '../../../shared/app_responsive/app_responsive.dart';
import '../../../shared/components/components.dart';
import '../../../shared/style/color.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class NotificationContent extends StatelessWidget {
  const NotificationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 15),
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
           title:  Center(child: Text("Best Rated Doctors",style: TextStyle(color: ColorManager.white,fontWeight: FontWeight.bold,fontSize: 20))),
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
               /*   RatingBar.builder(
                    initialRating:  vetList[index].AVGRATING ?? 0.0,

                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    ignoreGestures: true,
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate:
                        (double value) {},
                  ),
*/
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
    color: ColorManager.lightDarkNewColor,
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
        color: ColorManager.lightDarkNewColor,
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

