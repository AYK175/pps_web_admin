import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pps_web_admin/Screens/Doctors/doctor_view_profile/view_profile_screen.dart';
import 'package:pps_web_admin/Screens/Doctors/doctors_edit_screen/doctors_edit_screen.dart';
import 'package:pps_web_admin/Screens/HomePage/home.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Doctors/item_list.dart';

class DoctorScreen extends StatefulWidget {
  DoctorScreen({Key? key}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  // final user= FirebaseAuth.instance.currentUser!;
  bool _sortAscending = true;
  int _sortColumnIndex = 0;

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
              child: Column(
                children: [
                 DashboardName(title: "Vets List",),
                  Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0,bottom:10,left:5, right:5),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vets").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                    return DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromRGBO(26, 59, 106, 1.0)),
                      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20),
                      headingRowHeight: 80,
                      horizontalMargin: 3,
                      dataRowHeight: 40,
                      dividerThickness:2,
                      dataTextStyle: TextStyle(fontSize: 18,color: Colors.black),
                      showBottomBorder: true,
                      decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(26, 59, 106, 1.0), width: 1)),

                      sortAscending: _sortAscending,
                      sortColumnIndex: _sortColumnIndex,
                      columns: [
                        DataColumn(
                          label: Text("Name"),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              _sortAscending = sortAscending;
                              _sortColumnIndex = columnIndex;
                            });
                            if (sortAscending) {
                              docs.sort((a, b) => a["name"].toLowerCase().compareTo(b["name"].toLowerCase()));
                            } else {
                              docs.sort((a, b) => b["name"].toLowerCase().compareTo(a["name"].toLowerCase()));
                            }
                          },
                        ),
                        DataColumn(
                          label: Text("Email"),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              _sortAscending = sortAscending;
                              _sortColumnIndex = columnIndex;
                            });
                            if (sortAscending) {
                              docs.sort((a, b) => a["email"].toLowerCase().compareTo(b["email"].toLowerCase()));
                            } else {
                              docs.sort((a, b) => b["email"].toLowerCase().compareTo(a["email"].toLowerCase()));
                            }
                          },
                        ),
                        DataColumn(
                          label: Text("Profile Type"),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              _sortAscending = sortAscending;
                              _sortColumnIndex = columnIndex;
                            });
                            if (sortAscending) {
                              docs.sort((a, b) => a["ProfileType"].toLowerCase().compareTo(b["ProfileType"].toLowerCase()));
                            } else {
                              docs.sort((a, b) => b["ProfileType"].toLowerCase().compareTo(a["ProfileType"].toLowerCase()));
                            }
                          },
                        ),
                        DataColumn(
                          label: Text("Profile Status"),
                          onSort: (columnIndex, sortAscending) {
                            setState(() {
                              _sortAscending = sortAscending;
                              _sortColumnIndex = columnIndex;
                            });
                            if (sortAscending) {
                              docs.sort((a, b) => a["ProfileStatus"].toLowerCase().compareTo(b["ProfileStatus"].toLowerCase()));
                            } else {
                              docs.sort((a, b) => b["ProfileStatus"].toLowerCase().compareTo(a["ProfileStatus"].toLowerCase()));
                            }
                          },
                        ),
                        DataColumn(label: Text("View Profile")),
                        DataColumn(label: Text("Edit Profile")),

                      ],
                      rows: docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                        return DataRow(cells: [
                          DataCell(Text(data["name"])),
                          DataCell(Text(data["email"])),
                          DataCell(Text(data["ProfileType"])),
                          DataCell(Text(data["ProfileStatus"])),
                          DataCell(InkWell(
                              onTap: (){
                                Vets vet = vetList.firstWhere((vet) => vet.uid == document.id);

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ViewDoctorScreen(vets: vet);
                                    }));

                              },

                              child: Text("View profile",style: TextStyle(color: Colors.blue),))),
                          DataCell(InkWell(
                              onTap: (){
                                Vets vet = vetList.firstWhere((vet) => vet.uid == document.id);

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return DoctorEditScreen(vets: vet);
                                    }));

                              },

                              child: Text("Edit profile",style: TextStyle(color: Colors.blue),))),

                        ]);
                      }).toList(),
                    );
                  },
                ),
              )
                  ),
                ],
              ),
            ),
          ],
        ));
  }






}
