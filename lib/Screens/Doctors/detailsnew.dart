import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../HomePage/home.dart';
import 'item_list.dart';


class ItemDetails extends StatelessWidget {
ItemDetails(this.itemId, {Key? key}) : super(key: key) {
_reference =
FirebaseFirestore.instance.collection('vets').doc(itemId);
_futureData = _reference.get();
}

String itemId;
late DocumentReference _reference;

//_reference.get()  --> returns Future<DocumentSnapshot>
//_reference.snapshots() --> Stream<DocumentSnapshot>
late Future<DocumentSnapshot> _futureData;
late Map data;

@override
Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Scaffold(
    appBar: AppBar(
    title: Text("",style: TextStyle(color: Color.fromRGBO(
      214, 217, 220, 1.0), fontSize: 15),),

  centerTitle: true,
  backgroundColor: Color.fromRGBO(26, 59, 106, 1.0),
  elevation: 0,
  leading: GestureDetector(
  /*onTap: (){
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context)
  {
  return  HomePage();
  }
  )
  );
  },
    child: Icon(
      Icons.arrow_back_sharp,  // add custom icons also
    ),
*/
  )
    ),
  body: FutureBuilder<DocumentSnapshot>(
    future: _futureData,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Some error occurred. ${snapshot.error}'));
      }

      if (snapshot.hasData) {
        //Get the data
        DocumentSnapshot documentSnapshot = snapshot.data;
        data = documentSnapshot.data() as Map;
          var status= data['ProfileStatus'];
        //display the data
        return Container(
          width: width,
          height: height,
          child: Row(
            children: [
              Drawer(
                backgroundColor: Color.fromRGBO(26, 59, 106, 0.8745098039215686),

                child: ListView(

                  // Remove padding
                  padding: EdgeInsets.zero,
                  children: [

                    UserAccountsDrawerHeader(
                      accountName: Text('',style: TextStyle(
                        color: Colors.white,
                      )),
                      accountEmail: Text('' ,style: TextStyle(
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
                child: Padding(
                  padding: const EdgeInsets.only(left:13),
                  child: Container(
                    width: width*0.72,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          color: Color.fromRGBO(26, 59, 106, 1.0),
                        ),
                        Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Column(
                            children: [
                              Container(
                                height: height*0.35,
                                decoration:  BoxDecoration(
                                    color: Color.fromRGBO(25, 58, 106, 100),
                                    image: DecorationImage(
                                      image:NetworkImage("${data['profileImg']}"),)
                                ),
                              ),
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft:
                                    Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)),color: Colors.white),
                                child:ListView(children: [

                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  SizedBox(height: height*0.02,),
                                   Center(child: Text("${data['ProfileStatus']}",style: TextStyle(color: Color.fromRGBO(26, 59, 106, 1.0),fontWeight: FontWeight.bold,fontSize: 40,),)),
                                  Divider(
                                    height: 20,
                                    thickness: 3,
                                    indent: 40,
                                    endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.04),
                                    child: Center(child: Text("${data['name']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.0,),
                                    child: Center(child: Text("${data['subtitle']}",style: TextStyle(color: Colors.black54,fontSize: 20),)),),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  const Center(child: Text("PERSONAL INFORMATION",style: TextStyle(color: Color.fromRGBO(26, 59, 106, 1.0),fontWeight: FontWeight.bold,fontSize: 30,),)),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.04),
                                    child: Center(child: Text("Email:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text("${data['email']} ")),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.04),
                                    child: Center(child: Text("Phone Number:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text("${data['phone number']} ")),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Cnic:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01, bottom: height*0.01),
                                    child: Center(child: Text('${data['cnic']}')),),

                                  SizedBox(height: height*0.02,),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  const Center(child: Text("VET INFORMATION",style: TextStyle(color: Color.fromRGBO(26, 59, 106, 1.0),fontWeight: FontWeight.bold,fontSize: 32,),)),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("VetLiceance:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01, bottom: height*0.01),
                                    child: Center(child: Text('${data['VetLiceance']}')),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.04),
                                    child: Center(child: Text("Experience:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text("${data['year']} ")),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Qualification:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01, bottom: height*0.01),
                                    child: Center(child: Text('${data['specialization']}')),),
                                  SizedBox(height: height*0.02,),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  const Center(child: Text("CLINIC INFORMATION",style: TextStyle(color: Color.fromRGBO(26, 59, 106, 1.0),fontWeight: FontWeight.bold,fontSize: 30,),)),
                                  Divider(
                                      height: 20,
                                      thickness: 3,
                                      indent: 40,
                                      endIndent: 40,
                                      color: Color.fromRGBO(26, 59, 106, 1.0)
                                  ),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Clinic Name:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text('${data['ClinicName']}')),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Location:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text('${data['location']}')),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Timming:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02),
                                    child: Center(child: Text("Monday - Sunday")),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01, bottom: height*0.02),
                                    child: Center(child: Text('${data['start time']} to ${data['end time']}')),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("Charges:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.02, bottom: height*0.02),
                                    child: Center(child: Text("Rs: ${data['price']}")),),

                                  Padding(padding: EdgeInsets.only(left: width*0.0,top: height*0.01),
                                    child: Center(child: Text("About:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),),
                                  Padding(padding: EdgeInsets.only(left: width*0.0,right:width*0.02, top: height*0.02, bottom: height*0.01),
                                    child: Center(
                                      child: Text('${data['description']}',style: TextStyle(),textAlign: TextAlign.justify,
                                      ),
                                    ),),

                                  if(status=="UnApproved")
                                    ...[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: MaterialButton(onPressed: () async {
                                              final _db = FirebaseFirestore.instance;
                                              await _db.collection("vets").doc(itemId).update({
                                                "ProfileStatus": "Approved"
                                              });},
                                              minWidth: 300,
                                              height: 50,
                                              color: Color.fromRGBO(25, 58, 106, 5),
                                              child: Text("Approve Profile",style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]

                                ],
                                ),
                              )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );



      }

      return Center(child: CircularProgressIndicator());
    },
  ),
  );
}
}
