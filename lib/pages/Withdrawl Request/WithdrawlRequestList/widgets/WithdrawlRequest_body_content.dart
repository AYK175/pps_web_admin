import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Screens/Doctors/doctor_view_profile/view_profile_screen.dart';
import '../../../../Screens/Doctors/doctors_edit_screen/doctors_edit_screen.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import 'WithdrawlRequest_notification_content.dart';
import 'package:intl/intl.dart'; // import DateFormat class

class WithdrawlRequestBodyContent extends StatelessWidget {
  const WithdrawlRequestBodyContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              labelStyle: TextStyle(fontSize: 20),
              tabs: [
                Tab(text: 'New Withdrawal Request'),
                Tab(text: 'Completed Withdrawal Request'),
               ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(child:  const WitdrawRequestTable(),
                  ), // Content for Tab 1
                  SingleChildScrollView(child:  const CompletedWithdrawTable(),
                  ), // Content for Tab 1

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class WitdrawRequestTable extends StatelessWidget {
  const WitdrawRequestTable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vet Withdrawal Requests',
                style: TextStyle(color: ColorManager.white, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: ColorManager.darkColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.darkColor.withOpacity(0.5),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vet_funds_withdrawal_request").where("Status",isEqualTo: "WithdrawRequested").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> vetss = snapshot.data!.docs;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 35,
                        columns: [
                          DataColumn(
                            label: Text(
                              '#',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Vet Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Request Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Request Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),


                          DataColumn(
                            label: Text(
                              'Bank Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),

                        ],
                        rows: List.generate(
                          vetss.length,
                              (index) {
                            QueryDocumentSnapshot VetsWithdrawl = vetss[index];
                            String VetsWithdrawlID=VetsWithdrawl.id;
                            String email = VetsWithdrawl['VetEmail'] ?? '';
                            String accountTitle = VetsWithdrawl['accountTitle'] ?? '';

                            String bankName = VetsWithdrawl['bankName'] ?? '';
                            String ibanNumber = VetsWithdrawl['ibanNumber'] ?? '';
                            Timestamp Date = VetsWithdrawl['Date'] ?? '';
                            double amount = VetsWithdrawl['amount'] ?? '';
                            print("datess: $Date");

                            Timestamp timestamp = VetsWithdrawl['Date'] ?? '';
                            DateTime dateTime = timestamp.toDate();

                            String timeString = DateFormat('h:mm a').format(dateTime);
                            String dateString = DateFormat('yyyy-MM-dd').format(dateTime);

                            print('Time: $timeString'); // Output: Time: 3:30 PM
                            print('Date: $dateString'); // Output: Date: 2023-04-19

                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  email,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  dateString,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  timeString,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "Rs."+ amount.toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {
                                    showServicesAlertDialog(context, VetsWithdrawlID );
                                  },
                                  child: Text("Bank Details", style: TextStyle(color: Colors.blue)),
                                ),


                              ),
                              ]);
                          },
                        ),
                      ),
                    );






                  },
                ),    myDivider(),
              ],
            ),
          ),
        ],
      ),
    );

  }
  void showServicesAlertDialog(BuildContext context, String VetsWithdrawalID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.darkColor,
          title: const Text(''),
          content: SingleChildScrollView(
            child: Center(
              child: SizedBox(

                width: MediaQuery.of(context).size.width * 1/4,
                //height: MediaQuery.of(context).size.height * 0.51,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1/4,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 50),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Bank Details',
                            style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.darkColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.darkColor.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 3,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myDivider(),
                        StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('vet_funds_withdrawal_request')
                            .doc(VetsWithdrawalID)
                            .snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          String accountTitle = snapshot.data!.get('accountTitle') ?? '';
                          String BankName = snapshot.data!.get('bankName') ?? '';
                          String IBAN = snapshot.data!.get('accountTitle') ?? '';
                          double amount = snapshot.data!.get('amount') ?? '';
                          String Samount = snapshot.data!.get('amount').toString();

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('No data available');
                          } else {
                            // Do something with the document snapshot data
                            DocumentSnapshot withdrawalRequest = snapshot.data!;
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.center,

                                  children: [
                                  Text(
                                  'Account Title: '+accountTitle,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.orangeColor,
                                    fontSize: 15
                                  ),
                                  ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'Bank Name: '+BankName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'IBAN: '+IBAN,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      'Amount: Rs. '+Samount,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.orangeColor,
                                      ),
                                    ),
                                    SizedBox(height: 10,),

                                  ],
                                ),
                              ));
                          }
                        },
                      ),
                    myDivider(),
                        ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('vet_funds_withdrawal_request')
                      .doc(VetsWithdrawalID)
                      .update({'Status': 'Withdraw Completed'})
                      .then((value) {
                    Navigator.of(context).pop();
                  })
                      .catchError((error) => print("Failed to update status: $error"));
                },
                child: const Text('Withdraw'),
              ),
            ),
            SizedBox(height: 16 ),

          ],
        );
      },
    );
  }

}


class CompletedWithdrawTable extends StatelessWidget {
  const CompletedWithdrawTable({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Vet Withdrawal Requests',
                style: TextStyle(color: ColorManager.white, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: ColorManager.darkColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.darkColor.withOpacity(0.5),
                  offset: const Offset(0, 3),
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vet_funds_withdrawal_request").where("Status",isEqualTo: "Withdraw Completed").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> vetss = snapshot.data!.docs;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 40,
                        columns: [
                          DataColumn(
                            label: Text(
                              '#',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Vet Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Request Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Request Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Amount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),


                          DataColumn(
                            label: Text(
                              'Bank Details',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorManager.white,
                              ),
                            ),
                          ),

                        ],
                        rows: List.generate(
                          vetss.length,
                              (index) {
                            QueryDocumentSnapshot VetsWithdrawl = vetss[index];
                            String VetsWithdrawlID=VetsWithdrawl.id;
                            String email = VetsWithdrawl['VetEmail'] ?? '';
                            String accountTitle = VetsWithdrawl['accountTitle'] ?? '';

                            String bankName = VetsWithdrawl['bankName'] ?? '';
                            String ibanNumber = VetsWithdrawl['ibanNumber'] ?? '';
                            Timestamp Date = VetsWithdrawl['Date'] ?? '';
                            double amount = VetsWithdrawl['amount'] ?? '';
                            print("datess: $Date");

                            Timestamp timestamp = VetsWithdrawl['Date'] ?? '';
                            DateTime dateTime = timestamp.toDate();

                            String timeString = DateFormat('h:mm a').format(dateTime);
                            String dateString = DateFormat('yyyy-MM-dd').format(dateTime);

                            print('Time: $timeString'); // Output: Time: 3:30 PM
                            print('Date: $dateString'); // Output: Date: 2023-04-19

                            return DataRow(cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  email,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  dateString,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),

                              DataCell(
                                Text(
                                  timeString,
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "Rs."+ amount.toString(),
                                  style: const TextStyle(color: ColorManager.white),
                                ),
                              ),
                              DataCell(
                                InkWell(
                                  onTap: () {
                                    showServicesAlertDialog(context, VetsWithdrawlID );
                                  },
                                  child: Text("Bank Details", style: TextStyle(color: Colors.blue)),
                                ),


                              ),
                            ]);
                          },
                        ),
                      ),
                    );






                  },
                ),    myDivider(),
              ],
            ),
          ),
        ],
      ),
    );

  }
  void showServicesAlertDialog(BuildContext context, String VetsWithdrawalID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.darkColor,
          title: const Text(''),
          content: SingleChildScrollView(
            child: Center(
              child: SizedBox(

                width: MediaQuery.of(context).size.width * 1/4,
                //height: MediaQuery.of(context).size.height * 0.51,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1/4,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 50),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Bank Details',
                            style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.darkColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.darkColor.withOpacity(0.5),
                              offset: const Offset(0, 3),
                              spreadRadius: 3,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            myDivider(),
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('vet_funds_withdrawal_request')
                                  .doc(VetsWithdrawalID)
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                String accountTitle = snapshot.data!.get('accountTitle') ?? '';
                                String BankName = snapshot.data!.get('bankName') ?? '';
                                String IBAN = snapshot.data!.get('accountTitle') ?? '';
                                double amount = snapshot.data!.get('amount') ?? '';
                                String Samount = snapshot.data!.get('amount').toString();

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData) {
                                  return Text('No data available');
                                } else {
                                  // Do something with the document snapshot data
                                  DocumentSnapshot withdrawalRequest = snapshot.data!;
                                  return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,

                                          children: [
                                            Text(
                                              'Account Title: '+accountTitle,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorManager.orangeColor,
                                                  fontSize: 15
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              'Bank Name: '+BankName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.orangeColor,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              'IBAN: '+IBAN,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.orangeColor,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              'Amount: Rs. '+Samount,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.orangeColor,
                                              ),
                                            ),
                                            SizedBox(height: 10,),

                                          ],
                                        ),
                                      ));
                                }
                              },
                            ),
                            myDivider(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ),
            SizedBox(height: 16 ),

          ],
        );
      },
    );
  }

}


