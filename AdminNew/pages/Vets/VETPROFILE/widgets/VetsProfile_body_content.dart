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
import '../../VETEDIT/VetsEditScreen.dart';

class VetsProfileBodyContent extends StatefulWidget {
  Vets vets;
  String VetID;

  VetsProfileBodyContent({Key? key,required this.vets,required this.VetID}) : super(key: key);
  @override
  State<VetsProfileBodyContent> createState() => _VetsProfileBodyContentState();
}

class _VetsProfileBodyContentState extends State<VetsProfileBodyContent> {
   String? profileType='';

  @override
  void initState() {
    super.initState();
    getProfileType();
  }

  void getProfileType() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('vets').doc(widget.VetID).get();
      if (doc.exists) {
        setState(() {
          profileType = doc['ProfileType'];
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [

             VetProfileDetails(VetID: widget.VetID,),

          if(profileType =="Clinic")...[TableOfServicesAndClinics(VetID: widget.VetID,),]
          else...[TableOfServices(VetID: widget.VetID,),],
             TableOfAppiotments(VetID: widget.VetID,),
            const SizedBox(height: 5),
           ],
        ),
      ),
    );
  }}



class VetProfileDetails extends StatefulWidget {
  VetProfileDetails({Key? key,required this.VetID}) : super(key: key){
    _reference =
        FirebaseFirestore.instance.collection('vets').doc(VetID);
    _futureData = _reference.get();
  }

  String VetID;
  late DocumentReference _reference;

  late Future<DocumentSnapshot> _futureData;

  @override
  State<VetProfileDetails> createState() => _VetProfileDetailsState();
}

class _VetProfileDetailsState extends State<VetProfileDetails> {
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
                  future: widget._futureData,
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
                                        Center(
                                          child: Text(
                                            "${data['ProfileStatus']}".toUpperCase(), // Profile Status At top
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: kTitleTextColor),
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Image(image: NetworkImage("${data['profileImg']}"),
                                              height: 120,

                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${data['name']}",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold,
                                                        color: kTitleTextColor),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
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
                                              'Email: ${data['email']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                            Text(
                                              'Phone Number: ${data['phone number']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                            Text(
                                              'CNIC: ${data['cnic']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                            Text(
                                              'Vet Licence No: ${data['VetLiceance']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.7,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),

                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              'About Doctor:',
                                              style: TextStyle(

                                                  color: kTitleTextColor,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${data['description']}',
                                              textAlign: TextAlign.justify,


                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,

                                                  height: 1.6,
                                                  color: kTitleTextColor.withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
//Button
                                        Container(
                                          width: 150.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color: ColorManager.darkColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              // Check the current status of the profile
                                              if (data['ProfileStatus'] == 'Unapproved') {
                                                // Update the profile status to 'Approved'
                                                FirebaseFirestore.instance.collection('vets').doc(widget.VetID).update({
                                                  'ProfileStatus': 'Approved',
                                                }).then((value) {
                                                  // Update the state of the widget with the new value of ProfileStatus
                                                  setState(() {
                                                    data['ProfileStatus'] = 'Approved';
                                                  });
                                                });
                                              } else {
                                                // Update the profile status to 'Unapproved'
                                                FirebaseFirestore.instance.collection('vets').doc(widget.VetID).update({
                                                  'ProfileStatus': 'Unapproved',
                                                }).then((value) {
                                                  // Update the state of the widget with the new value of ProfileStatus
                                                  setState(() {
                                                    data['ProfileStatus'] = 'Unapproved';
                                                  });
                                                });
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                (data['ProfileStatus'] == 'Unapproved') ? 'Approve Profile' : 'Unapprove Profile',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
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
  String VetID;

   TableOfAppiotments({Key? key,required this.VetID}) : super(key: key);

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
                  stream: FirebaseFirestore.instance.collection("booking").where("serviceId",isEqualTo: widget.VetID).snapshots(),
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
                        columnSpacing: 75,
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
                              'Customer Email',
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
                                  userEmail,
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

class TableOfServicesAndClinics extends StatefulWidget {
  String VetID;

  TableOfServicesAndClinics({Key? key,required this.VetID}) : super(key: key);

  @override
  State<TableOfServicesAndClinics> createState() => _TableOfServicesAndClinicsState();
}

class _TableOfServicesAndClinicsState extends State<TableOfServicesAndClinics> {
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
                'Clinics List',
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
                  stream: FirebaseFirestore.instance.collection("Clinics").where("vetids",isEqualTo: widget.VetID).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> clinics = snapshot.data!.docs;


                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 28,
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
                              'Clinic Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Clinic Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Time Slot Duration',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              'Opening Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),


                          DataColumn(
                            label: Text(
                              'Closing Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Days',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Services',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),


                        ],
                        rows: List.generate(
                          clinics.length,
                              (index) {
                            QueryDocumentSnapshot clinic = clinics[index];
                            String clinicid= clinic.id;
                            String clinicName = clinic['clinicName'];
                            String clinicAddress = clinic['clinicAddress'];
                            String timeSlotDuration = clinic['timeSlotDuration'];
                            String startTime = clinic['startTime'];
                            String endTime = clinic['endTime'];
                            List<String> selectedDays = List<String>.from(clinic['selectedDays']);


                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  clinicName,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  clinicAddress,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  timeSlotDuration,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  startTime,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  endTime,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  selectedDays.skip(1).join(', '),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),

                              DataCell(
                                InkWell(
                                  onTap: () {
                                    showServicesAlertDialog(context, clinicid);
                                  },
                                  child: Text("View Services", style: TextStyle(color: Colors.blue)),
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
               ],
            ),
          ),
        ],
      ),
    );

  }

  void showServicesAlertDialog(BuildContext context, String clinicId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.darkColor,
          title: const Text(''),
          content: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2/3,
                //height: MediaQuery.of(context).size.height * 0.51,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Services List',
                          style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            stream: FirebaseFirestore.instance.collection("Services").where("clinicId", isEqualTo: clinicId).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              List<QueryDocumentSnapshot> VAHSERVICES = snapshot.data!.docs;


                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columnSpacing: 87,
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
                                        'Service Title',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.orangeColor,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Service Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.orangeColor,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        'Service Description',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.orangeColor,
                                        ),
                                      ),
                                    ),

                                    DataColumn(
                                      label: Text(
                                        'Price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.orangeColor,
                                        ),
                                      ),
                                    ),



                                  ],
                                  rows: List.generate(
                                    VAHSERVICES.length,
                                        (index) {
                                      QueryDocumentSnapshot service = VAHSERVICES[index];
                                      String serviceTitle = service['serviceTitle'];
                                      String serviceType= service['serviceType'];
                                      String serviceDescription = service['serviceDescription'];
                                      String price = service['price'];



                                      return DataRow(cells: [
                                        DataCell(
                                          Text(
                                            (index + 1).toString(),
                                            style: const TextStyle(color: ColorManager.white),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            serviceTitle,
                                            style: const TextStyle(color: ColorManager.white),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            serviceType,
                                            style: const TextStyle(color: ColorManager.white),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            serviceDescription,
                                            style: const TextStyle(color: ColorManager.white),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            "RS. "+price,
                                            style: const TextStyle(color: ColorManager.white),
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
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

}


class TableOfServices extends StatefulWidget {
  String VetID;

  TableOfServices({Key? key,required this.VetID}) : super(key: key);

  @override
  State<TableOfServices> createState() => _TableOfServicesState();
}

class _TableOfServicesState extends State<TableOfServices> {
  // final user= FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 2/3,
      //height: MediaQuery.of(context).size.height * 0.51,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Services List',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                  stream: FirebaseFirestore.instance.collection("Services").where("userId",isEqualTo: widget.VetID).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> VAHSERVICES = snapshot.data!.docs;


                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 87,
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
                              'Service Title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Service Type',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Service Description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),

                          DataColumn(
                            label: Text(
                              'Price',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.orangeColor,
                              ),
                            ),
                          ),



                        ],
                        rows: List.generate(
                          VAHSERVICES.length,
                              (index) {
                            QueryDocumentSnapshot service = VAHSERVICES[index];
                            String serviceTitle = service['serviceTitle'];
                            String serviceType= service['serviceType'];
                            String serviceDescription = service['serviceDescription'];
                            String price = service['price'];



                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  serviceTitle,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  serviceType,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  serviceDescription,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "RS. "+price,
                                  style: const TextStyle(color: ColorManager.white),
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



