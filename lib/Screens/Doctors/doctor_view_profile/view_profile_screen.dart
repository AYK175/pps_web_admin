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

import '../services.dart';


class ViewDoctorScreen extends StatefulWidget {
  Vets vets;
  ViewDoctorScreen({Key? key,required this.vets}) : super(key: key);

  @override
  _ViewDoctorScreenState createState() => _ViewDoctorScreenState();
}

class _ViewDoctorScreenState extends State<ViewDoctorScreen> {
  // final user= FirebaseAuth.instance.currentUser!;
  List<Bookings> booking=[];
  List<Users> user=[];
  late Stream<QuerySnapshot> _clinicsStream;
  late Stream<QuerySnapshot> _servicesStream;

  @override
  void initState() {
    setState(() {
      booking =
          bookingList.where((booking) => booking.serviceId == widget.vets.uid).toList();
      booking.forEach((element) {
        user.add(userList.where((user) => user.uid == element.userId).toList().first);
      });
      print(booking);
      _clinicsStream = FirebaseFirestore.instance
          .collection('Clinics')
          .where('vetids', isEqualTo: widget.vets.uid)
          .snapshots();

      _servicesStream = FirebaseFirestore.instance
          .collection('Services')
          .where('userId', isEqualTo: widget.vets.uid)
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
                  DashboardName(title: "Doctors Dashboard",),
                  Expanded(
                    child: Column(children: [
                      Container(width: 200,height: 200,decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(widget.vets.profileImg.toString()),fit: BoxFit.cover),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)
                      ),),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(
                          title: Text("${widget.vets.name.toString()}\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,)),
                          trailing:Text("${widget.vets.email.toString()}",style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(title: Text("\nDescription\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                        subtitle: Text(widget.vets.description.toString(),style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(title: Text("Profile Type\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                          trailing: Text(widget.vets.profileType.toString(),style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(title: Text("Vet Licence\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                          trailing: Text(widget.vets.vetLiceance.toString(),style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(title: Text("Vet Cnic\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                          trailing: Text(widget.vets.cnic.toString(),style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(title: Text("Vet Phone Number\n",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),),
                          trailing: Text(widget.vets.phoneNumber.toString(),style: TextStyle(fontSize: 18),),
                        ),
                      ),

                      if (widget.vets.profileType.toString()=="Clinic") ...[
                        Text("Clinics",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

                        Padding(
    padding: const EdgeInsets.all(8.0),
    child: StreamBuilder<QuerySnapshot>(
    stream: _clinicsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
    return CircularProgressIndicator();
    }

    List<DataRow> rows = [];
    snapshot.data!.docs.forEach((clinic) {
    String clinicName = clinic['clinicName'];
    String clinicAddress = clinic['clinicAddress'];
    String timeSlotDuration = clinic['timeSlotDuration'];
    String startTime = clinic['startTime'];
    String endTime = clinic['endTime'];
    List<String> selectedDays = List<String>.from(clinic['selectedDays']);

    rows.add(DataRow(cells: [
    DataCell(Text(clinicName)),
    DataCell(Text(clinicAddress)),
    DataCell(Text(timeSlotDuration)),
    DataCell(Text(startTime)),
    DataCell(Text(endTime)),
    DataCell(Text(selectedDays.skip(1).join(', '))),
    DataCell(InkWell(
    onTap: () {
    Navigator.of(context).push(
    MaterialPageRoute(
    builder: (context) =>
    ViewServicesScreen(ClinicID:clinic.id,)));
    },

    child: Text("View Services",style: TextStyle(color: Colors.blue),)),),

    ]));
    });

    return DataTable(
    columns: [
    DataColumn(label: Text('Clinic Name')),
    DataColumn(label: Text('Clinic Address')),
    DataColumn(label: Text('Time Slot Duration')),
    DataColumn(label: Text('Start Time')),
    DataColumn(label: Text('End Time')),
    DataColumn(label: Text('Selected Days')),
    DataColumn(label: Text('Services')),

    ],
    rows: rows,
    );
    },
    ),
    ),]
                      else ...[
                        Text("Services",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

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
                      ],


                      Text("Appointments",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      booking.length>0?

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Sr No.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('User Name.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Email',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Appointment Status',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Fee',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Time',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Change',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                              ],
                              decoration: BoxDecoration(color: Color.fromRGBO(26, 59, 106, 1.0)),
                            ),
                            for(int i=0;i<booking.length;i++)
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(i.toString())),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(user[i].lastname.toString())),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(user[i].email.toString())),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(booking[i].userName.toString(),style: TextStyle(color:booking[i].userName.toString()=="Canceled"?Colors.red:booking[i].userName.toString()=="Completed"?Colors.green:Colors.blue ),)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(booking[i].servicePrice.toString())),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text("${DateTime.tryParse(booking[i].bookingStart.toString())!.day}/${DateTime.tryParse(booking[i].bookingStart.toString())!.month}/${DateTime.tryParse(booking[i].bookingStart.toString())!.year}")),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text("${DateTime.tryParse(booking[i].bookingStart.toString())!.hour}:${DateTime.tryParse(booking[i].bookingStart.toString())!.minute==0?"00":DateTime.tryParse(booking[i].bookingStart.toString())!.minute}")),
                                    ),
                                  ),
                                  TableCell(
                                    child: TextButton(onPressed: (){
                                    },child: Text("Edit",style: TextStyle(color: Colors.blue),),),
                                  ),
                                ],
                                decoration: BoxDecoration(color: Colors.grey.shade200),
                              ),
                          ],
                        ),
                      ):
                      Container(),

                      ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)
                        ),
                        onPressed: () async {
                          FirebaseFirestore.instance.collection("vets").doc(widget.vets.uid).update({"ProfileStatus":"UnApproved"});
                          }, child: Text("Not Approve"),
                      ),
                      SizedBox(
                        height: 20,
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