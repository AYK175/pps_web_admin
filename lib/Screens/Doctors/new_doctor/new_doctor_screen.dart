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
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class NewDoctorScreen extends StatefulWidget {
  NewDoctorScreen({Key? key}) : super(key: key);

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<NewDoctorScreen> {
  // final user= FirebaseAuth.instance.currentUser!;
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
                  DashboardName(title: "New Doctors",),
                  Expanded(
                    child: newVetList.length>0?GridView.builder(
                      padding: REdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              _StackBgCard(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _doctorsProfile(index: index),
                                  _doctorStats(index: index),
                                  Container(
                                    height: 0.1.sh,
                                    margin: REdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    )
                                                ),
                                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.green)
                                            ),
                                            onPressed: () async {
                                                  FirebaseFirestore.instance.collection("vets").doc(newVetList[index].uid).update({"ProfileStatus":"Approved"});
                                                  vetList.clear();
                                                  newVetList.clear();
                                                  await getValue();
                                                  setState(() {});
                                            }, child: Text("Approve"),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                ),
                                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)
                                            ),
                                            onPressed: () async {
                                              FirebaseFirestore.instance.collection("vets").doc(newVetList[index].uid).update({"ProfileStatus":"UnApproved"});
                                              setState(() {});
                                              await getValue();
                                              setState(() {});
                                            }, child: Text("Not Approve"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: newVetList.length,
                    ):Center(child: Text("No Vet To Show",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),), ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
  getValue() async {
    vetList   =await fetchDoctors();
    newVetList   =await fetchNewDoctors();
    setState(() {});
    print(userList);
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
                image: NetworkImage(newVetList[index]
                    .profileImg
                    .toString()),fit: BoxFit.cover)),
      ),
      title: Text(newVetList[index].name.toString()),
      subtitle: Text(newVetList[index].email.toString()),
    ),
  );



  Widget _doctorStats({required int index})=> Container(
    height: 0.1.sh,
    margin: REdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Card(child: Center(child: ListTile(title: Text(newVetList[index].year.toString()),subtitle: Text("Doctors Experience"),),),)),
        SizedBox(width:10,),
        Expanded(child: Card(child: Center(child: ListTile(title: Text(newVetList[index].qualification.toString(),overflow: TextOverflow.ellipsis,maxLines: 2),subtitle: Text("Doctors Qualification"),),),)),
        SizedBox(width:10,),
        Expanded(child: Card(child: Center(child: ListTile(title: Text(newVetList[index].price.toString()),subtitle: Text("Doctors Services"),),),)),
      ],),
  );

}
