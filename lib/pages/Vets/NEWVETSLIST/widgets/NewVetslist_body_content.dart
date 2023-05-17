import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import '../../VETEDIT/VetsEditScreen.dart';
import '../../VETPROFILE/VetsProfileScreen.dart';
import 'NewVetsList_notification_content.dart';

class NewVetsListBodyContent extends StatelessWidget {
  const NewVetsListBodyContent({Key? key}) : super(key: key);
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
            /*if(!AppResponsive.isDesktop(context))
              const NewVetsListNotificationContent(),
          */],
        ),
      ),
    );
  }
}


class TableOfEmployee extends StatelessWidget {
  const TableOfEmployee({Key? key}) : super(key: key);
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vets").where("ProfileStatus",isEqualTo: "UnApproved").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> vetss = snapshot.data!.docs;

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
                              'Reason',
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
                            String reason = vetsss['ProfileUnapprovalReason'] ?? '';

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
                                Text(
                                  reason,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),

                              DataCell(
                                InkWell(
                                  onTap: () {
                                    Vets vet = vetList.firstWhere((vet) => vet.uid == vetsss.id);
                                    String vetUidString = vet.uid.toString();

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return VetsProfileScreen(VetID:vetsss.id,);
                                    }));
                                  },
                                  child: Text("View profile", style: TextStyle(color: Colors.blue)),
                                ),


                              ),
                              DataCell(
                                InkWell(
                                    onTap: (){
                                      Vets vet = vetList.firstWhere((vet) => vet.uid == vetsss.id);

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return VetsEditScreen(vets: vet);
                                          }));

                                    },

                                    child: Text("Edit profile",style: TextStyle(color: Colors.blue),) ),
                              ),
                              ]);
                          },
                        ),
                      ),
                    );






                  },
                ),    myDivider(),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'view 4 from 40',
                      style: TextStyle(
                        color: ColorManager.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('View More')),
                  ],
                ),
              */],
            ),
          ),
        ],
      ),
    );
  }
}




