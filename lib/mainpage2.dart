import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/pages/HomePageNew/HomePageNew.dart';
import 'package:pps_web_admin/pages/home/home_page.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getValue();
    super.initState();
  }
  getValue() async {
    userCount = await getUser();
    vetCount = await getVets();
    clinicCount = await getClinic();
    bookingList = await getBookings();
    vetList   =await fetchDoctors();
    newVetList =await fetchNewDoctors();
    userList=await fetchUsers();
    bookingCount = bookingList.length;
    setState(() {});
    print(userList);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context, snapshot){
        if (snapshot.hasData) {
          return HomePageScreen();
        } else {
          return LoginScreen();
        }
      },
      )
    );

  }
}
