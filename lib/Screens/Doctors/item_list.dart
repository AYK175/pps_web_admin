import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import '../HomePage/home.dart';
import 'detailsnew.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
  FirebaseFirestore.instance.collection('vets');
  final user= FirebaseAuth.instance.currentUser!;

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        color: Color.fromRGBO(166, 166, 166, 1.0),
        child: Row(
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
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                height: h,
                width: w*0.7,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //Check error
                    if (snapshot.hasError) {
                      return Center(child: Text('Some error occurred ${snapshot.error}'));
                    }

                    //Check if data arrived
                    if (snapshot.hasData) {
                      //get the data
                      QuerySnapshot querySnapshot = snapshot.data;
                      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                      final User? currentUser = FirebaseAuth.instance.currentUser!;

                      //Convert the documents to Maps
                      List<Map> items = documents.map((e) =>
                      {
                        'id': e.id,
                        'name': e['name'],
                        'subtitle': e['subtitle'],
                        'profileImg': e['profileImg'],
                        'year': e['year'],
                        'price': e['price'],
                        'ClinicName': e['ClinicName'],
                        'ProfileStatus': e['ProfileStatus'],
                        'email': e['email'],

                      }).toList();

                      //Display the list
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            //Get the item at this index
                            Map thisItem = items[index];
                            var status= thisItem['ProfileStatus'];

                            //REturn the widget for the list items
                            return Padding(
                              padding: const EdgeInsets.only(left: 0,right: 50,top: 10,bottom: 10),
                              child: Center(
                                child: Container(
                                  width: w*0.4,
                                  height: h*0.3,
                                  color: Color.fromRGBO(1, 24, 47, 1.0),
                                  child:Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: h*0.3,
                                            child: Image(image: NetworkImage("${thisItem['profileImg']}")),
                                          ),
                                          SizedBox(
                                            height: h*0.3,
                                            child: VerticalDivider(
                                              width: 15,
                                              color: Colors.white, //color of divider
                                              thickness: 5, //thickness of divier line
                                              indent: 1, //spacing at the start of divider
                                              endIndent: 1, //spacing at the end of divider
                                            ),),


                                          SizedBox(
                                            height: h*0.3,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 45,top: 15),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      "${thisItem['ProfileStatus']}",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35,color: Colors.white),
                                                    ),
                                                  ),

                                                  Text(
                                                    "Name: ${thisItem['name']}",
                                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Subtitle: ${thisItem['subtitle']}",
                                                    style: TextStyle(
                                                        fontSize: 14, color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Clinic Name: ${thisItem['ClinicName']}",
                                                    style: TextStyle(
                                                        fontSize: 14, color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Email: ${thisItem['email']}",
                                                    style: TextStyle(fontSize: 14, color: Colors.white),
                                                  ),

                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ItemDetails(thisItem['id'] )));
                                                    },

                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:5),
                                                      child: Container(
                                                        width: 250,
                                                        height: 40,
                                                        decoration:
                                                        BoxDecoration(color:  Colors.white,
                                                            borderRadius: BorderRadius.circular(24)),
                                                        padding:  EdgeInsets.all(5),
                                                        child: const Center(
                                                          child: Text(
                                                            "View Details",
                                                            style: TextStyle(color: Color.fromRGBO(1, 24, 47, 1.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )

                                        ],

                                      ),



                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    //Show loader
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ), //Display a list // Add a FutureBuilder
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    */);
  }
}
