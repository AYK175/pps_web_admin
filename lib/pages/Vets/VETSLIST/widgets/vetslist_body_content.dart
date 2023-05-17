import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import '../../../HomePageNew/widgets/notification_content.dart';
import '../../VETEDIT/VetsEditScreen.dart';
import '../../VETPROFILE/VetsProfileScreen.dart';

class VetsListBodyContent extends StatelessWidget {
  const VetsListBodyContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const TableOfEmployee(),
            const SizedBox(height: 5),
            if(!AppResponsive.isDesktop(context))
              const NotificationContent(),
          ],
        ),
      ),
    );
  }
}


class TableOfEmployee extends StatefulWidget {
  const TableOfEmployee({Key? key}) : super(key: key);

  @override
  State<TableOfEmployee> createState() => _TableOfEmployeeState();
}

class _TableOfEmployeeState extends State<TableOfEmployee> {
  String _searchText = '';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.51,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vets List',
                style: TextStyle(color: ColorManager.white, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: ColorManager.darkColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.darkColor.withOpacity(0.5),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 450.0),
                  child: Container(
                    alignment: Alignment.topRight,
                    constraints: BoxConstraints(
                      maxWidth: 260,
                      maxHeight: 30, // set your desired maximum width
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.4),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vets").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> vetss = snapshot.data!.docs
                        .where((document) =>
                    document['ProfileType']
                        .toLowerCase()
                        .contains(_searchText.toLowerCase()) ||
                        document['phone number']
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        document['name']
                            .toLowerCase()
                            .contains(_searchText.toLowerCase())

                        ||
                        document['email']
                            .toLowerCase()
                            .contains(_searchText.toLowerCase())


                    )
                        .toList() ..sort((a, b) => a['name']
                        .toLowerCase()
                        .compareTo(b['name'].toLowerCase()));


                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 15,
                        columns: [
                          DataColumn(
                            label: Text(
                              '#',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Vet Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Profile Type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Profile Status',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              'View Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),

                        ],
                        rows: List.generate(
                          vetss.length,
                              (index) {
                            QueryDocumentSnapshot vetsss = vetss[index];
                            String name = vetsss['name'] ?? '';
                            String email = vetsss['email'] ?? '';
                            String PhoneNumber = vetsss['phone number'] ?? '';
                            String profileType = vetsss['ProfileType'] ?? '';
                            String profileStatus = vetsss['ProfileStatus'] ?? '';
                            String profileUnapprovalReason = vetsss['ProfileUnapprovalReason'] ?? '';
                            bool shouldDisplay = true;
                            if (profileStatus == 'Unapproved' && profileUnapprovalReason == 'New User') {
                              shouldDisplay = false;
                            }
                            if (shouldDisplay) {
                              return DataRow(cells: [
                                DataCell(
                                  Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    name,
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    email,
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    PhoneNumber,
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    profileType,
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    profileStatus,
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  InkWell(
                                    onTap: () {
                                      Vets vet = vetList.firstWhere((vet) => vet.uid == vetsss.id);
                                      String vetUidString = vet.uid.toString();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return VetsProfileScreen( VetID:vetsss.id,);
                                      }));
                                    },
                                    child: Text("View profile", style: TextStyle(color: Colors.blue)),
                                  ),
                                ),
                                DataCell(
                                  InkWell(
                                    onTap: (){
                                      Vets vet = vetList.firstWhere((vet) => vet.uid == vetsss.id);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return VetsEditScreen(vets: vet);
                                      }));
                                    },
                                    child: Text("Edit profile",style: TextStyle(color: Colors.blue),),
                                  ),
                                ),
                              ]);
                            } else {
                              return DataRow(cells: [
                                  DataCell(
                                  Text(
                                 "",
                                    style: const TextStyle(color: ColorManager.white),
                                ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    "",
                                    style: const TextStyle(color: ColorManager.white),
                                  ),
                                ),

                                ]
                              );
                            }
                          },
                        ),
                      ),
                    );






                  },
                ),    myDivider(),
               ],
            ),
          ),
        ],
      ),
    );
  }
}




