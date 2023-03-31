import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pps_web_admin/Screens/Doctors/doctors_edit_screen/doctors_edit_screen.dart';
import 'package:pps_web_admin/Screens/HomePage/home.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/bookings.dart';
import 'package:pps_web_admin/model/users_model.dart';
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class ViewServicesScreen extends StatefulWidget {
  String ClinicID;
  ViewServicesScreen({Key? key,required this.ClinicID}) : super(key: key);

  @override
  _ViewServicesScreenState createState() => _ViewServicesScreenState();
}

class _ViewServicesScreenState extends State<ViewServicesScreen> {
  late Stream<QuerySnapshot> _servicesStream;


  @override
  void initState() {
    setState(() {

      _servicesStream = FirebaseFirestore.instance
          .collection('Services')
          .where('clinicId', isEqualTo: widget.ClinicID)
          .snapshots();
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            CustomDrawer(),
            SizedBox(
              width: 0.02.sw,
            ),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  DashboardName(title: "Vets Services",),
                  Expanded(
                    child: Column(children: [
      
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                          child:StreamBuilder<QuerySnapshot>(
                            stream: _servicesStream,
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              List<DataRow> rows = [];
                              snapshot.data!.docs.forEach((service) {
                                String serviceTitle = service['serviceTitle'];
                                String serviceDescription = service['serviceDescription'];
                                String price = service['price'];

                                rows.add(DataRow(cells: [
                                  DataCell(Text(serviceTitle)),
                                  DataCell(Text(serviceDescription)),
                                  DataCell(Text(price)),
                                ]));
                              });

                              return Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DataTable(
                                  columnSpacing: 16.0,
                                  dataRowHeight: 72.0,
                                  columns: [
                                    DataColumn(
                                      label: Text('Service Title'),
                                      tooltip: 'The title of the service',
                                      numeric: false,
                                    ),
                                    DataColumn(
                                      label: Text('Service Description'),
                                      tooltip: 'A description of the service',
                                      numeric: false,
                                    ),
                                    DataColumn(
                                      label: Text('Price'),
                                      tooltip: 'The price of the service',
                                      numeric: true,
                                    ),
                                  ],
                                  rows: rows,
                                ),
                              );
                            },
                          ),
                       ),
                    ],),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

}
