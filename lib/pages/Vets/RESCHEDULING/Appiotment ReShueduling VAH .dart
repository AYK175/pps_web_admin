import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:booking_calendar/booking_calendar.dart';

import '../../../shared/app_responsive/app_responsive.dart';
import '../../../shared/components/side_menu_widget.dart';
import '../../../shared/style/color.dart';
import '../VETPROFILE/VetsProfileScreen.dart';

class AppointReScheduleVAH extends StatefulWidget {
  String vetID;
  String serviceID;
  String servicePrice;
  String bookingId;
  String BookUserName;
  String BookUserEmail;


  AppointReScheduleVAH(
      {Key? key, required this.vetID, required this.serviceID, required this.servicePrice,required this.bookingId,required this.BookUserName,required this.BookUserEmail})
      : super(key: key);

  @override
  State<AppointReScheduleVAH> createState() => _AppointReScheduleVAHState();
}

class _AppointReScheduleVAHState extends State<AppointReScheduleVAH> {

  final now = DateTime.now();
  late BookingService mockBookingService;
  CollectionReference _reference = FirebaseFirestore.instance.collection(
      'booking');
  final user = FirebaseAuth.instance.currentUser!;
  String? startTimevet;
  String? timeslotduration;
  int timeslotdurationint = 30;
  String? endTimevet;
  List<int>? unselectedDays;
  bool display = false;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedTimesaf = DateFormat('kk:mm:a').format(now);
    String formattedDatesaf = formatter.format(now);
    //print(formattedTimesaf);
    //print(formattedDatesaf);
    return formattedTimesaf;
  }

  @override
  void initState() {
    super.initState();
    fetchVetData().then((value) {
      int endmin = 0;
      print("starttime=$startTimevet");
      print("endtime=$endTimevet");
      DateTime timestart = DateFormat.jm().parse(startTimevet!);
      DateTime timeend = DateFormat.jm().parse(endTimevet!);
      String timestarthours = DateFormat("HH").format(timestart);
      String timestartmin = DateFormat("mm").format(timestart);
      String timeendhours = DateFormat("HH").format(timeend);
      String timeendtmin = DateFormat("mm").format(timeend);
      int startHour = int.parse(timestarthours!);
      int startmin = int.parse(timestartmin!);
      int endhour = int.parse(timeendhours!);
      endmin = int.parse(timeendtmin!);


      mockBookingService = BookingService(
        serviceName: widget.serviceID,
        serviceId: widget.vetID,
        //vetid
        servicePrice: int.parse(widget.servicePrice),
        serviceDuration: timeslotdurationint,
        bookingEnd: DateTime(
            now.year, now.month, now.day, endhour + 1, endmin),
        bookingStart: DateTime(
            now.year, now.month, now.day, startHour, startmin),
        userEmail: widget.BookUserEmail,
        userId: widget.BookUserName,

        userName: "Accepted",
        userPhoneNumber: "NotGiven",//appointment status

      );
      getData(mockBookingService);
      setState(() {
        display = true;
      });
    });
  }

  Future<void> fetchVetData() async {
    try {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('HomeVetTime').doc(widget.vetID).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          startTimevet = data['startTime'];
          endTimevet = data['endTime'];
          timeslotduration = data['timeSlotDuration'];
          timeslotdurationint = int.parse(timeslotduration!);
          unselectedDays = List<int>.from(data['unselectedDays']);
          print("unselectedDays =  ");

          print(unselectedDays);
        });
      } else {
        print('Vet data not found');
      }
    } catch (e) {
      print('Error fetching vet data: $e');
    }
  }

  getData(BookingService booking) async {
    //here is the code where
    int timenow = DateTime
        .now()
        .hour;
    int bookingStart = booking.bookingStart.hour;

    for (int i = bookingStart; i < timenow; i++) {
      converted.add(DateTimeRange(
          start: DateTime(now.year, now.month, now.day, i, 0),
          end: DateTime(now.year, now.month, now.day, i, 30)));
      converted.add(DateTimeRange(
          start: DateTime(now.year, now.month, now.day, i, 30),
          end: DateTime(now.year, now.month, now.day, i, 61)));
      //print("$converted\n");
    }
    // print("$converted\n");
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        "booking").where("serviceId", isEqualTo: widget.vetID).where(
        "userName", whereIn: ['Accepted', 'In Process']).get();
    List<QueryDocumentSnapshot> list = snapshot.docs;
    for (int i = 0; i < list.length; i++) {
      Map map = list[i].data() as Map;
      DateTime startTime = DateTime.parse(map["bookingStart"]);
      DateTime endTime = DateTime.parse(map["bookingEnd"]);
      setState(() {
        converted.add(DateTimeRange(start: startTime, end: endTime));
      });
    }
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    FirebaseFirestore.instance.collection("booking").doc(widget.bookingId).update(newBooking.toJson());  //print('${newBooking.toJson()} has been uploaded');
    Navigator
        .push(context, MaterialPageRoute(builder: (context) {
      return VetsProfileScreen(VetID: widget.vetID);
    }
    ));
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    // print("first:$first\n2:$second\n3:$third\n4:$fourth");

    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));
    return converted;
  }

/*
  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 23, 0),
          end: DateTime(now.year, now.month, now.day, 24, 0))
    ];
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightDarkColor,
      body: display
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Side menu
          if (AppResponsive.isDesktop(context))
            Expanded(
              flex: 2,
              child: SideMenuWidget(),
            ),

          /// Main content
          Expanded(
            flex: 9,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  color: ColorManager.white,

                  width: 400, // set the width of the container
                  height: 650, // set the height of the container
                  child: BookingCalendar(
                    bookedSlotTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 14),
                    availableSlotTextStyle:
                    TextStyle(color: Colors.white, fontSize: 14),
                    availableSlotColor: Color.fromRGBO(26, 59, 106, 1.0),
                    bookedSlotColor: Colors.red[900],
                    selectedSlotTextStyle: TextStyle(
                        color: Colors.red[900],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    bookingService: mockBookingService,
                    bookingButtonColor: Color.fromRGBO(26, 59, 106, 1.0),
                    bookingButtonText: "Book Appointment ",
                    convertStreamResultToDateTimeRanges:
                    convertStreamResultMock,
                    getBookingStream: getBookingStreamMock,
                    uploadBooking: uploadBookingMock,
                    formatDateTime: DateFormat('h:mm a').format,
                    //pauseSlots: generatePauseSlots(),
                    // pauseSlotText: 'LUNCH',
                    hideBreakTime: false,
                    loadingWidget: const Text('Fetching data...'),
                    uploadingWidget: const CircularProgressIndicator(),
                    disabledDays: unselectedDays,
                  ),

                ),
              ),
            ),
          )
        ],
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
