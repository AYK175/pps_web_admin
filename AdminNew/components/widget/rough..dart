import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pps_web_admin/Screens/Doctors/doctor_screen.dart';
import 'package:pps_web_admin/Screens/Doctors/new_doctor/new_doctor_screen.dart';
import 'package:pps_web_admin/Screens/HomePage/home.dart';
import 'package:pps_web_admin/Screens/chat_screen/chat_screen.dart';
import 'package:pps_web_admin/Screens/users/user_screen.dart';

import '../../Screens/clinics.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Expanded(
      flex: 1,
      child: Container(
        color: Color.fromRGBO(26, 59, 106, 0.8745098039215686),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  'Hi, '
                  // + user.email!
                  ,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              accountEmail: Text('How is Your Pet Health?',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              /*currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('android/Images/logo.png',
                  fit: BoxFit.fitHeight,
                  width: 110,
                  height: 110,
                ),
              ),
          ),*/
              decoration: BoxDecoration(
                //color:Color.fromRGBO(26, 59, 106, 0.023529411764705882),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text('Home',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                }),
            ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text('Users',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return UserScreen();
                      }));
                }),
            ListTile(
                leading: Icon(
                  Icons.monitor_heart_outlined,
                  color: Colors.white,
                ),
                title: Text('Vets',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return DoctorScreen();
                      }));
                }),
            ListTile(
                leading: Icon(
                  Icons.new_releases_rounded,
                  color: Colors.white,
                ),
                title: Text('New Vets',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return NewDoctorScreen();
                      }));
                }),
            ListTile(
              leading: Icon(
                Icons.headset,
                color: Colors.white,
              ),
              title: Text('Contact and support',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return ChatScreen();
                    }));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: Text('Settings',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return MyTable(data: [],);
                    }));
              },),
            Divider(),
            ListTile(
              title: Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
