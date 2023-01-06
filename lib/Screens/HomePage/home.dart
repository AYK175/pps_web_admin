import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Doctors/item_list.dart';
import 'navbar.dart';


class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user= FirebaseAuth.instance.currentUser!;

  PageController page = PageController();
  String title="Home";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(26, 59, 106, 1.0),

      ),
      body: Container(
      child:Row(
        children: [
          Drawer(
            backgroundColor: Color.fromRGBO(26, 59, 106, 0.8745098039215686),

            child: ListView(

              // Remove padding
              padding: EdgeInsets.zero,
              children: [

                UserAccountsDrawerHeader(
                  accountName: Text('Hi, '+ user.email!,style: TextStyle(
                    color: Colors.white,
                  )),
                  accountEmail: Text('How is Your Pet Health?' ,style: TextStyle(
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
                    leading: Icon(Icons.home,color: Colors.white,),
                    title: Text('Home',style: TextStyle(
                      color: Colors.white,
                    )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              }
                          )
                      );
                    }
                ),

                ListTile(
                    leading: Icon(Icons.person,color: Colors.white,),
                    title: Text('Vets',style: TextStyle(
                      color: Colors.white,
                    )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return ItemList();
                              }
                          )
                      );
                    }
                ),
                ListTile(
                  leading: Icon(Icons.settings,color: Colors.white,),
                  title: Text('Settings',style: TextStyle(
                    color: Colors.white,
                  )),
                  onTap: () => null,
                ),
                Divider(),
                ListTile(
                  title: Text('Logout',style: TextStyle(
                    color: Colors.white,
                  )),
                  leading: Icon(Icons.exit_to_app,color: Colors.white,),
                  onTap: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Center(child: Text("Home Page",style: TextStyle(color: Color.fromRGBO(26, 59, 106, 1.0),fontWeight: FontWeight.bold,fontSize: 40,))),
              )
            ],
    ),
          ),
        ],
      ),
    )
    );
  }
}
