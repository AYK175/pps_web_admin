import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pps_web_admin/Screens/HomePage/home.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/bookings.dart';
import 'package:pps_web_admin/model/users_model.dart';
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Doctors/item_list.dart';

class UserViewScreen extends StatefulWidget {
  Users user;
  UserViewScreen({Key? key,required this.user}) : super(key: key);

  @override
  _UserViewScreenState createState() => _UserViewScreenState();
}

class _UserViewScreenState extends State<UserViewScreen> {
  // final user= FirebaseAuth.instance.currentUser!;
  List<Bookings> booking=[];
  List<Vets> vet=[];
  @override
  void initState() {
    setState(() {
      booking =
          bookingList.where((booking) => booking.userId == widget.user.uid).toList();
      booking.forEach((element) {
        vet.add(vetList.where((vets) => vets.uid == element.serviceId).toList().first);
      });
      print(booking);
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
              child: Column(
                children: [
                  DashboardName(title: "Users View",),
                  SizedBox(height: 0.02.sh,),
                  Expanded(
                    child: Column(children: [
                      Container(width: 200,height: 200,decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(widget.user.profileImg.toString()),fit: BoxFit.cover),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)
                      ),),
                      Padding(
                        padding: REdgeInsets.only(left: 20.0,right: 40),
                        child: ListTile(
                        title: Text("${widget.user.firstname.toString()}"),
                        subtitle:Text("${widget.user.email.toString()}"),
                          trailing: Text("Wallet\n${widget.user.wallet.toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
                        ),
                      ),
                      Text("Appointments",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      booking.length>0?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                // start date
                                // end date
                                // fee
                                // status
                                // Vet name
                                // vet clinic
                                // sr no

                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Sr No.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Vet Name.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Vet Type',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    child: Center(child: Text('Status',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
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
                              ],
                              decoration: BoxDecoration(color: Colors.grey.shade300),
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
                                      child: Center(child: Text(vet[i].name.toString())),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      child: Center(child: Text(vet[i].profileType.toString())),
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
                                ],
                                decoration: BoxDecoration(color: Colors.grey.shade300),
                              ),
                          ],
                        ),
                      ):
                      Container(),
                    ],),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
  Widget _StackBgCard() => Column(
    children: [
      Expanded(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/doctor.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              color: Colors.blue.withOpacity(0.5),
            ),
          )),
      Expanded(
          child: Container(
            color: Colors.white,
          )),
    ],
  );



  Widget _doctorsProfile({required int index})=>  Card(
    margin: REdgeInsets.all(10),
    color: Colors.white,
    child: ListTile(
      contentPadding: REdgeInsets.all(10),
      visualDensity: const VisualDensity(vertical: 4),
      leading: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(userList[index]
                    .profileImg
                    .toString()),fit: BoxFit.cover)),
      ),
      title: Text(userList[index].firstname.toString()),
      subtitle: Text(userList[index].email.toString()),
    ),
  );



  Widget _doctorStats({required int index})=> Container(
    height: 0.1.sh,
    margin: REdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Card(child: Center(child: ListTile(title: Text(userList[index].phnumber.toString()),subtitle: Text("Phone number"),),),)),
        SizedBox(width:10,),
        Expanded(child: Card(child: Center(child: ListTile(title: Text(userList[index].cNIC.toString(),overflow: TextOverflow.ellipsis,maxLines: 2),subtitle: Text("Doctors Qualification"),),),)),
        SizedBox(width:10,),
      ],),
  );

}
