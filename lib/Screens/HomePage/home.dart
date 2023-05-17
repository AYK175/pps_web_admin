import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pps_web_admin/Screens/Doctors/doctor_screen.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Doctors/item_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
           CustomDrawer(),
            SizedBox(
              width: 0.05.sw,
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  DashboardName(title: "Doctors Dashboard",),
                  Row(
                    children: [
                      _userCard(),
                      Expanded(
                        child: Column(
                          children: [
                            Row(children: [
                              _statsCard(
                                  label: 'Available Users',
                                  value: '${userCount} Users',
                                  icon: Icon(
                                    Icons.supervised_user_circle_sharp,
                                    size: 50,
                                    color: kPrimaryColor,
                                  )),
                              _statsCard(
                                  label: 'Available Doctors',
                                  value: '${vetCount} Doctors',
                                  icon: Icon(
                                    Icons.monitor_heart_outlined,
                                    size: 50,
                                    color: kPrimaryColor,
                                  )),
                            ]),
                            Row(children: [
                              _statsCard(
                                  label: 'Total Clinics',
                                  value: '${clinicCount} Clinics',
                                  icon: Icon(
                                    Icons.local_hospital,
                                    size: 50,
                                    color: kPrimaryColor,
                                  )),
                              _statsCard(
                                  label: 'Total Bookings',
                                  value: '${bookingCount} Bookings',
                                  icon: Icon(
                                    Icons.book_online,
                                    size: 50,
                                    color: kPrimaryColor,
                                  )),
                            ]),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 11,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 8,
                              child: SizedBox(height: 0.5.sh, child: graph()))),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Container(height: 0.10.sh,
                                      decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16))),
                                  child: Center(child: Text("Best Rated Doctors List",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),),
                                SizedBox(height: 0.02.sh,),
                                Container(
                                  height: 0.38.sh,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16))),
                                  child: vetList.length>0?ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 8,
                                          child: ListTile(
                                            visualDensity: VisualDensity(vertical: 4),
                                            leading: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(vetList[index].profileImg.toString()),
                                                  fit: BoxFit.cover
                                                ),
                                                shape: BoxShape.circle
                                              ),
                                            ),
                                            title: Text(vetList[index].name.toString()),
                                            subtitle: Text(vetList[index].email.toString()),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount: vetList.length):Center(child: CircularProgressIndicator(),),
                                ),
                              ],
                            ),
                          )),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _userCard() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Container(
          width: 0.3.sw,
          height: 0.25.sh,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                  image: AssetImage("assets/images/main_card.png"),
                  fit: BoxFit.fill)),
        ),
      );

  Widget _statsCard(
          {required String label,
          required String value,
          required Widget icon}) =>
      Card(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SizedBox(
            width: 0.22.sw,
            height: 0.12.sh,
            child: Center(
              child: ListTile(
                leading: icon,
                title: Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  label,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ));

  Widget graph() => SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_SalesData, String>>[
            LineSeries<_SalesData, String>(
                dataSource: [
                  _SalesData('Jan', 35),
                  _SalesData('Feb', 28),
                  _SalesData('Mar', 34),
                  _SalesData('Apr', 32),
                  _SalesData('May', 40)
                ],
                xValueMapper: (_SalesData sales, _) => sales.month,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]);
}

class _SalesData {
  _SalesData(this.month, this.sales);

  final String month;
  final double sales;
}
