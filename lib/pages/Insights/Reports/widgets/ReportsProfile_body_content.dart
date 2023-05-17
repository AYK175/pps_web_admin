import 'dart:math';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import 'package:intl/intl.dart';

import '../../../HomePageNew/widgets/notification_content.dart';

class ReportsBodyContent extends StatefulWidget {

  ReportsBodyContent({Key? key,}) : super(key: key);
  @override
  State<ReportsBodyContent> createState() => _ReportsBodyContentState();
}

class _ReportsBodyContentState extends State<ReportsBodyContent> {
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
                Tab(text: 'Last 7 Days'),
                Tab(text: 'Last 30 Days'),
                Tab(text: 'Last 1 Year'),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(child: ReportsDetails7Days()), // Content for Tab 1
                  SingleChildScrollView(child: ReportsDetails30Days()), // Content for Tab 1
                  SingleChildScrollView(child: ReportsDetails365Days()), // Content for Tab 1

                ],
              ),
            ),
            const SizedBox(height: 20),
            /*  const TableOfEmployee(),
          */  if(!AppResponsive.isDesktop(context))
              const NotificationContent(),

          ],
        ),
      ),
    );
  }
}


class ReportsDetails7Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.51,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             /* const Text(
                'Vet Profile',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            */],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

            SingleChildScrollView(
            child: Container(
            width: double.infinity,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('comapny_temp_wallet').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        // Get the current date and subtract 7 days in UTC timezone
                        final now = DateTime.now().toUtc();
                        final lastWeek = now.subtract(Duration(days: 7));
                        print('now: $now, lastWeek: $lastWeek');

                        int completedCount = 0;
                        num totalCompanyEarning = 0;
                        num totalVETEarning = 0;
                        num totalReveune = 0;

                        int cancelledByUserCount = 0;
                        int cancelledByVetCount = 0;

                        for (final doc in snapshot.data!.docs) {
                          final bookingDateStr = doc['BookingDate'];
                          try {
                            final bookingDate = DateFormat('E, MMM d, y').parse(bookingDateStr).toUtc();
                            if (bookingDate.isAfter(lastWeek)) {
                              if (doc['status'] == 'Completed') {
                                completedCount++;
                                final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                totalCompanyEarning += companyEarning;
                                final VETEarning = num.tryParse(doc['VETEarning'].toString()) ?? 0;
                                totalVETEarning += VETEarning;
                                final Revenue = num.tryParse(doc['TotalServicePrice'].toString()) ?? 0;
                                totalReveune += Revenue;

                              }
                              else if (doc['status'] == 'Cancelled by Vet') {
                                cancelledByVetCount++;
                                print('Cancelled by Vet documents count: $cancelledByVetCount');

                              }

                              else if (doc['status'] == 'Cancelled by User') {
                                cancelledByUserCount++;
                                final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                totalCompanyEarning += companyEarning;
                                totalReveune += companyEarning;


                              }
                              else if (doc['status'] == 'Cancelled by Vet') {
                                cancelledByVetCount++;
                                print('Cancelled by Vet documents count: $cancelledByVetCount');

                              }
                            }
                          } catch (e) {
                            print('Error parsing date for doc ${doc['title']}: $e');
                          }
                        }

                        print('Completed documents count: $completedCount');
                        print('Total CompanyEarning from completed documents: $totalCompanyEarning');
                        print('Total VetEarning from completed documents: $totalVETEarning');
                        print('Total Revunue from completed documents: $totalReveune');
                        print('Cancelled by Vet documents count: $cancelledByVetCount');
                        print('Cancelled user documents count: $cancelledByUserCount');
                        final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
                        List<CircularStackEntry> data = <CircularStackEntry>[
                          new CircularStackEntry(
                            <CircularSegmentEntry>[
                              new CircularSegmentEntry(cancelledByUserCount.toDouble(), Colors.green, rankKey: 'Cancelled By User Bokings'),
                              new CircularSegmentEntry(cancelledByVetCount.toDouble(), Colors.red, rankKey: 'Cancelled By Vet Bokings'),
                              new CircularSegmentEntry(completedCount.toDouble(), Colors.blue, rankKey: 'Completed Bokings'),
                              ],
                            rankKey: 'Bookings',
                          ),
                        ];
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50),bottom:  Radius.circular(50)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                           SizedBox(
                                            height: 3,
                                          ),

                                         
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                        AnimatedCircularChart(
                        key: _chartKey,
                        size: const Size(300.0, 300.0),
                        initialChartData: data,
                        chartType: CircularChartType.Pie,
                        ),
                                    Center(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [    Container(
                                          width: 11,
                                          height: 11,
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                          Text(
                                            'Total Completed Bookings: $completedCount',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              height: 1.7,
                                              color: kTitleTextColor.withOpacity(0.8),
                                            ),
                                          ),
                                        ]
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          Container(
                                            width: 11,
                                            height: 11,
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            'Total Cancelled By User Bookings: $cancelledByUserCount',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Container(
                                            width: 11,
                                            height: 11,
                                            margin: EdgeInsets.only(right: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            'Total Cancelled By Vet Bookings: $cancelledByVetCount',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)
                                            ),
                                          ),
                                          SizedBox(width: 20),

                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Total Vets Earning : $totalVETEarning',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          height: 1.7,
                                          color: kTitleTextColor.withOpacity(0.8)),
                                    ),

                                    Text(
                                      'Total Revenue Generated: $totalReveune',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          height: 1.7,
                                          color: kTitleTextColor.withOpacity(0.8)),
                                    ),
                                    Text(
                                      'Total Company Profit : $totalCompanyEarning ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          height: 1.7,
                                          color: kTitleTextColor.withOpacity(0.8)),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),


                              ],
                            ),
                          ),
                        );

                      },
                    ),

                    ],
                ),
              ),
            ),
          ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReportsDetails30Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.51,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* const Text(
                'Vet Profile',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            */],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('comapny_temp_wallet').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              // Get the current date and subtract 7 days in UTC timezone
                              final now = DateTime.now().toUtc();
                              final lastWeek = now.subtract(Duration(days: 30));
                              print('now: $now, lastWeek: $lastWeek');

                              int completedCount = 0;
                              num totalCompanyEarning = 0;
                              num totalVETEarning = 0;
                              num totalReveune = 0;

                              int cancelledByUserCount = 0;
                              int cancelledByVetCount = 0;

                              for (final doc in snapshot.data!.docs) {
                                final bookingDateStr = doc['BookingDate'];
                                try {
                                  final bookingDate = DateFormat('E, MMM d, y').parse(bookingDateStr).toUtc();
                                  if (bookingDate.isAfter(lastWeek)) {
                                    if (doc['status'] == 'Completed') {
                                      completedCount++;
                                      final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                      totalCompanyEarning += companyEarning;
                                      final VETEarning = num.tryParse(doc['VETEarning'].toString()) ?? 0;
                                      totalVETEarning += VETEarning;
                                      final Revenue = num.tryParse(doc['TotalServicePrice'].toString()) ?? 0;
                                      totalReveune += Revenue;

                                    }
                                    else if (doc['status'] == 'Cancelled by Vet') {
                                      cancelledByVetCount++;
                                      print('Cancelled by Vet documents count: $cancelledByVetCount');

                                    }

                                    else if (doc['status'] == 'Cancelled by User') {
                                      cancelledByUserCount++;
                                      final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                      totalCompanyEarning += companyEarning;

                                    }
                                    else if (doc['status'] == 'Cancelled by Vet') {
                                      cancelledByVetCount++;
                                      print('Cancelled by Vet documents count: $cancelledByVetCount');

                                    }
                                  }
                                } catch (e) {
                                  print('Error parsing date for doc ${doc['title']}: $e');
                                }
                              }

                              print('Completed documents count: $completedCount');
                              print('Total CompanyEarning from completed documents: $totalCompanyEarning');
                              print('Total VetEarning from completed documents: $totalVETEarning');
                              print('Total Revunue from completed documents: $totalReveune');
                              print('Cancelled by Vet documents count: $cancelledByVetCount');
                              print('Cancelled user documents count: $cancelledByUserCount');
                              final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
                              List<CircularStackEntry> data = <CircularStackEntry>[
                                new CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    new CircularSegmentEntry(cancelledByUserCount.toDouble(), Colors.green, rankKey: 'Cancelled By User Bokings'),
                                    new CircularSegmentEntry(cancelledByVetCount.toDouble(), Colors.red, rankKey: 'Cancelled By Vet Bokings'),
                                    new CircularSegmentEntry(completedCount.toDouble(), Colors.blue, rankKey: 'Completed Bokings'),
                                  ],
                                  rankKey: 'Bookings',
                                ),
                              ];
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(50),bottom:  Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),


                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          AnimatedCircularChart(
                                            key: _chartKey,
                                            size: const Size(300.0, 300.0),
                                            initialChartData: data,
                                            chartType: CircularChartType.Pie,
                                          ),
                                          Center(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,

                                                children: [    Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                  Text(
                                                    'Total Completed Bookings: $completedCount',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'Total Cancelled By User Bookings: $cancelledByUserCount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8)
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'Total Cancelled By Vet Bookings: $cancelledByVetCount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8)
                                                  ),
                                                ),
                                                SizedBox(width: 20),

                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Total Vets Earning : $totalVETEarning',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),

                                          Text(
                                            'Total Revenue Generated: $totalReveune',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),
                                          Text(
                                            'Total Company Profit : $totalCompanyEarning ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),


                                    ],
                                  ),
                                ),
                              );

                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ReportsDetails365Days extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.51,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* const Text(
                'Vet Profile',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
              ),
            */],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('comapny_temp_wallet').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              // Get the current date and subtract 7 days in UTC timezone
                              final now = DateTime.now().toUtc();
                              final lastWeek = now.subtract(Duration(days: 365));
                              print('now: $now, lastWeek: $lastWeek');

                              int completedCount = 0;
                              num totalCompanyEarning = 0;
                              num totalVETEarning = 0;
                              num totalReveune = 0;

                              int cancelledByUserCount = 0;
                              int cancelledByVetCount = 0;

                              for (final doc in snapshot.data!.docs) {
                                final bookingDateStr = doc['BookingDate'];
                                try {
                                  final bookingDate = DateFormat('E, MMM d, y').parse(bookingDateStr).toUtc();
                                  if (bookingDate.isAfter(lastWeek)) {
                                    if (doc['status'] == 'Completed') {
                                      completedCount++;
                                      final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                      totalCompanyEarning += companyEarning;
                                      final VETEarning = num.tryParse(doc['VETEarning'].toString()) ?? 0;
                                      totalVETEarning += VETEarning;
                                      final Revenue = num.tryParse(doc['TotalServicePrice'].toString()) ?? 0;
                                      totalReveune += Revenue;

                                    }
                                    else if (doc['status'] == 'Cancelled by Vet') {
                                      cancelledByVetCount++;
                                      print('Cancelled by Vet documents count: $cancelledByVetCount');

                                    }

                                    else if (doc['status'] == 'Cancelled by User') {
                                      cancelledByUserCount++;
                                      final companyEarning = num.tryParse(doc['CompanyEarning'].toString()) ?? 0;
                                      totalCompanyEarning += companyEarning;

                                    }
                                    else if (doc['status'] == 'Cancelled by Vet') {
                                      cancelledByVetCount++;
                                      print('Cancelled by Vet documents count: $cancelledByVetCount');

                                    }
                                  }
                                } catch (e) {
                                  print('Error parsing date for doc ${doc['title']}: $e');
                                }
                              }

                              print('Completed documents count: $completedCount');
                              print('Total CompanyEarning from completed documents: $totalCompanyEarning');
                              print('Total VetEarning from completed documents: $totalVETEarning');
                              print('Total Revunue from completed documents: $totalReveune');
                              print('Cancelled by Vet documents count: $cancelledByVetCount');
                              print('Cancelled user documents count: $cancelledByUserCount');
                              final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
                              List<CircularStackEntry> data = <CircularStackEntry>[
                                new CircularStackEntry(
                                  <CircularSegmentEntry>[
                                    new CircularSegmentEntry(cancelledByUserCount.toDouble(), Colors.green, rankKey: 'Cancelled By User Bokings'),
                                    new CircularSegmentEntry(cancelledByVetCount.toDouble(), Colors.red, rankKey: 'Cancelled By Vet Bokings'),
                                    new CircularSegmentEntry(completedCount.toDouble(), Colors.blue, rankKey: 'Completed Bokings'),
                                  ],
                                  rankKey: 'Bookings',
                                ),
                              ];
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(50),bottom:  Radius.circular(50)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),


                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          AnimatedCircularChart(
                                            key: _chartKey,
                                            size: const Size(300.0, 300.0),
                                            initialChartData: data,
                                            chartType: CircularChartType.Pie,
                                          ),
                                          Center(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,

                                                children: [    Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                  Text(
                                                    'Total Completed Bookings: $completedCount',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8),
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'Total Cancelled By User Bookings: $cancelledByUserCount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8)
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Container(
                                                  width: 11,
                                                  height: 11,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  'Total Cancelled By Vet Bookings: $cancelledByVetCount',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      height: 1.7,
                                                      color: kTitleTextColor.withOpacity(0.8)
                                                  ),
                                                ),
                                                SizedBox(width: 20),

                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Total Vets Earning : $totalVETEarning',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),

                                          Text(
                                            'Total Revenue Generated: $totalReveune',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),
                                          Text(
                                            'Total Company Profit : $totalCompanyEarning ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                height: 1.7,
                                                color: kTitleTextColor.withOpacity(0.8)),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),


                                    ],
                                  ),
                                ),
                              );

                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
