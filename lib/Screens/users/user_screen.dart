import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pps_web_admin/Screens/HomePage/home.dart';
import 'package:pps_web_admin/Screens/user_view_screen/user_view_screen.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/vet.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Doctors/item_list.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
                  DashboardName(title: "Users Dashboard",),
                  Expanded(
                    child: GridView.builder(
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
                                    child: Center(child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              )
                                          )
                                      ),
                                      onPressed: () {
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserViewScreen(user: userList[index],)));
                                      }, child: Text("View Profile"),
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: userList.length,
                    ),
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
        Expanded(child: Card(child: Center(child: ListTile(title: Text(userList[index].cNIC.toString(),overflow: TextOverflow.ellipsis,maxLines: 2),subtitle: Text("User CNIC"),),),)),
        SizedBox(width:10,),
      ],),
  );

}
