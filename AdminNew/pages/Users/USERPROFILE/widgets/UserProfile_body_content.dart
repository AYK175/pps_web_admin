import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Screens/Doctors/doctor_view_profile/view_profile_screen.dart';
import '../../../../Screens/Doctors/doctors_edit_screen/doctors_edit_screen.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';

class UserProfileBodyContent extends StatefulWidget {
  String UserID;

  UserProfileBodyContent({Key? key,required this.UserID}) : super(key: key);
  @override
  State<UserProfileBodyContent> createState() => _UserProfileBodyContentState();
}

class _UserProfileBodyContentState extends State<UserProfileBodyContent> {

  @override
  void initState() {
    super.initState();
   }

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

             VetProfileDetails(UserID: widget.UserID,),
             TableOfAppiotments(UserID: widget.UserID,),
            const SizedBox(height: 5),
           ],
        ),
      ),
    );
  }}



class VetProfileDetails extends StatelessWidget {
  VetProfileDetails({Key? key,required this.UserID}) : super(key: key){
    _reference =
        FirebaseFirestore.instance.collection('user').doc(UserID);
    _futureData = _reference.get();
  }

  String UserID;
  late DocumentReference _reference;

  late Future<DocumentSnapshot> _futureData;
  late Map data;

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
                'Vet Profile',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FutureBuilder<DocumentSnapshot>(
                  future: _futureData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Some error occurred. ${snapshot.error}'));
                    }

                    if (snapshot.hasData) {
                      //Get the data
                      DocumentSnapshot documentSnapshot = snapshot.data;
                      data = documentSnapshot.data() as Map;

                      //display the data
                      return SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: SafeArea(
                            bottom: false,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius:
                                    BorderRadius.vertical(top: Radius.circular(50),bottom:  Radius.circular(50)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Row(
                                          children: [
                                         /*   Image(image: NetworkImage("${data['profileImg']}"),
                                              height: 120,

                                            ),
                                         */  /* SizedBox(
                                              width: 15,
                                            ),
                                           */ Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Wallet Balance: ${data['wallet']}",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold,
                                                        color: kTitleTextColor),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  /*Text(
                                                    "${data['specialization']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,

                                                        color: kTitleTextColor.withOpacity(0.7)),
                                                    overflow: TextOverflow.ellipsis,maxLines: 2,
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    "${data['qualification']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,

                                                        color: kTitleTextColor.withOpacity(0.7)),
                                                    overflow: TextOverflow.ellipsis,maxLines: 2,

                                                  ),
                                                  Text(
                                                    "Experience: ${data['year']}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,

                                                        color: kTitleTextColor.withOpacity(0.7)),
                                                    overflow: TextOverflow.ellipsis,maxLines: 2,

                                                  ),
*/
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            Text(
                                              'PERSONAL INFORMATION:',
                                              style: TextStyle(
                                                  color: kTitleTextColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),

                                            Text(
                                              'Name: ${data['firstname']}'+'${data['lastname']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),

                                            Text(
                                              'Email: ${data['email']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                            Text(
                                              'Phone Number: ${data['phnumber']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                            Text(
                                              'CNIC: ${data['CNIC']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );


                    }

                    return Center(child: CircularProgressIndicator());
                  },
                )
                ],
            ),
          ),
        ],
      ),
    );
  }
}


class TableOfAppiotments extends StatefulWidget {
  String UserID;

   TableOfAppiotments({Key? key,required this.UserID}) : super(key: key);

  @override
  State<TableOfAppiotments> createState() => _TableOfAppiotmentsState();
}

class _TableOfAppiotmentsState extends State<TableOfAppiotments> {
  // final user= FirebaseAuth.instance.currentUser!;

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
                'Appointments List',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
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
                  stream: FirebaseFirestore.instance.collection("booking").where("userId",isEqualTo: widget.UserID).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> bookings = snapshot.data!.docs;


                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 115,
                        columns: [
                          DataColumn(
                            label: Text(
                              '#',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              'Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Fee',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),


                          DataColumn(
                            label: Text(
                              'Appointment Status',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Edit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),


                        ],
                        rows: List.generate(
                          bookings.length,
                              (index) {
                            QueryDocumentSnapshot booking = bookings[index];
                            String userEmail = booking['userEmail'] ?? '';
                            String bookingEnd = booking['bookingEnd'] ?? '';
                            String userPhoneNumber = booking['userPhoneNumber'] ?? '';
                            double servicePrice = booking['servicePrice'] ?? 0.0;
                            int serviceDuration = booking['serviceDuration'] ?? 0;
                            String bookingStart = booking['bookingStart'] ?? '';
                            String serviceName = booking['serviceName'] ?? '';
                            String userId = booking['userId'] ?? '';
                            String serviceId = booking['serviceId'] ?? '';
                            String userName = booking['userName'] ?? '';

                               String servicePriceString = servicePrice.toStringAsFixed(2);

                            DateTime bookingDateTime = DateTime.parse(bookingStart);

                                String bookingdate = "${bookingDateTime.day}-${bookingDateTime.month}-${bookingDateTime.year}";
                                String bookingtime = "${bookingDateTime.hour > 12 ? bookingDateTime.hour - 12 : bookingDateTime.hour}:${bookingDateTime.minute} ${bookingDateTime.hour >= 12 ? 'PM' : 'AM'}";
                            Color boxColor;
                            Color textColor;

                            switch(userName) {
                              case 'Accepted':
                                boxColor = Color(0xFF013638);
                                textColor = Colors.white;
                                break;
                              case 'Completed':
                                boxColor =Color(0xFFD78542);
                                textColor =  Color(0xFF10153B);
                                break;
                              case 'Cancelled':
                                boxColor = Colors.red;
                                textColor = Colors.white;
                                break;
                              default:
                                boxColor = Colors.transparent;
                                textColor = Colors.black;
                                break;
                            }
                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  bookingdate,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  bookingtime,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  servicePriceString,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),

                              DataCell(
                                  Container(
                                    decoration: BoxDecoration(
                                      color: boxColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0,right:8,top:3,bottom:3),
                                      child: Text(
                                        userName,
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                  ),),
                              DataCell(
                                InkWell(
                                  onTap: () {
                                    Vets vet = vetList.firstWhere((vet) => vet.uid == vet.uid);

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return ViewDoctorScreen(vets: vet);
                                    }));
                                  },
                                  child: Text("Edit", style: TextStyle(color: Colors.blue)),
                                ),


                              ),

                            ]);
                          },
                        ),
                      ),
                    );
                  },
                ),
                myDivider(),
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



