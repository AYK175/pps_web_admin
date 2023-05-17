import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../model/users_model.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import '../../../HomePageNew/widgets/notification_content.dart';
import '../../USEREDIT/USEREditScreen.dart';
import '../../USERPROFILE/UserProfileScreen.dart';

class UserListBodyContent extends StatelessWidget {
  const UserListBodyContent({Key? key}) : super(key: key);
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
                'Users List',
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
                  stream: FirebaseFirestore.instance.collection("user").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> UserList = snapshot.data!.docs;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 13,
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
                              'Name',
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
                              'CNIC',
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
                          UserList.length,
                              (index) {
                            QueryDocumentSnapshot users = UserList[index];
                            String Fname = users['firstname'] ?? '';
                            String Lname = users['lastname'] ?? '';
                            String email = users['email'] ?? '';
                            String PhNum = users['phnumber'] ?? '';
                            String Cnic = users['CNIC'] ?? '';

                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  Fname+" "+Lname,
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
                                  PhNum,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  Cnic,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return UserProfileScreen(UserID:users.id,);
                                    }));
                                  },
                                  child: Text("View profile", style: TextStyle(color: Colors.blue)),
                                ),


                              ),
                              DataCell(
                                InkWell(
                                    onTap: (){

                                      Users user = userList.firstWhere((user) => user.uid == users.id);

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return UserEditScreen(users: user,);
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




