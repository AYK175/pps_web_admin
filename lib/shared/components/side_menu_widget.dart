import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../pages/HomePageNew/HomePageNew.dart';
import '../../pages/Insights/Reports/ReportsScreen.dart';
import '../../pages/Users/USERLIST/UserListScreen.dart';
import '../../pages/Vets/NEWVETSLIST/NewVetsLIstScreen.dart';
import '../../pages/Vets/VETSLIST/VetsLIstScreen.dart';
import '../../pages/Withdrawl Request/WithdrawlRequestList/WithdrawlRequestScreen.dart';
import '../style/color.dart';
import '../../model/list_item_model.dart';
import 'components.dart';
import '../../pages/home/home_page.dart';
import '../../pages/home/newdart.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int unapprovedVetCount = 0;
  int WithdrawlCount = 0;

  @override
  void initState() {
    super.initState();
    getDocCount();
    FirebaseFirestore.instance
        .collection("vets")
        .where("ProfileStatus", isEqualTo: "UnApproved")
        .get()
        .then((querySnapshot) {
      setState(() {
        unapprovedVetCount = querySnapshot.size;
      });
    });
  }
  Future<void> getDocCount() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('vet_funds_withdrawal_request')
          .where('Status', isEqualTo: 'WithdrawRequested')
          .get();
      if (querySnapshot != null) {
        setState(() {
          WithdrawlCount = querySnapshot.size;
        });
      }
    } catch (e) {
      print('Error getting document count: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: ColorManager.darkColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(
                  children: const [
                    Icon(
                      Icons.dashboard,
                      color: ColorManager.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'PPS ADMIN',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    // Spacer(),
                    // Icon(
                    //   Icons.circle_notifications,
                    //   color: ColorManager.primaryColor,
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child:Column(
                  children: [
                    ListTile(
                        minLeadingWidth : 10,
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
                                return HomePageScreen();
                              }));
                        }),
                    ListTile(
                        minLeadingWidth : 10,
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
                                return UserListScreen();
                              }));
                        }),
                    ListTile(
                        minLeadingWidth : 10,
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
                                return VetsListScreen();
                              }));
                        }),
                    ListTile(
                        minLeadingWidth : 10,
                        leading: Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.white,
                        ),
                        title: Row(
                          children: [
                            Text('Pending Vets',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                      SizedBox(width: 5,),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),

                        child: Center(
                          child: Text(
                            unapprovedVetCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return NewVetsListScreen();
                              }));
                        }),
                    ListTile(
                        minLeadingWidth : 10,
                        leading: Icon(
                          Icons.stacked_bar_chart,
                          color: Colors.white,
                        ),
                        title: Text('Reports',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return ReportsScreen();
                              }));
                        }),
                    ListTile(
                        minLeadingWidth : 10,
                        leading: Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        title: Row(
                          children: [
                            Text('Withdraw Funds',
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                              overflow: TextOverflow.ellipsis,maxLines: 2,

                            ),
                            SizedBox(width: 5,),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),

                              child: Center(
                                child: Text(
                                  WithdrawlCount.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return WithdrawlRequestScreen();
                              }));
                        }),

                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}

