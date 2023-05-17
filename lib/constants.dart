import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pps_web_admin/model/bookings.dart';
import 'package:pps_web_admin/model/users_model.dart';
import 'package:pps_web_admin/model/vet.dart';

const kPrimaryColor = Color(0xDF1A3B6A);
const kPrimaryLightColor = Color(0xFFE6E7FF);
var kBackgroundColor = Color(0xffF9F9F9);
var kWhiteColor = Color(0xffffffff);
var kOrangeColor = Color(0xffEF716B);
var kBlueColor = Color(0xff4B7FFB);
var kYellowColor = Color(0xffFFB167);
var kTitleTextColor = Color(0xff1E1C61);
var kSearchBackgroundColor = Color(0xffF2F2F2);
var kSearchTextColor = Color(0xffC0C0C0);
var kCategoryTextColor = Color(0xff292685);
var kCategoryTextColor2 = Color(0xd8010c41);

const double defaultPadding = 16.0;

  // final user= FirebaseAuth.instance.currentUser!;
  int userCount = 0;
  int vetCount = 0;
  int clinicCount = 0;
  List<Bookings> bookingList = [];
  int bookingCount = 0;
  List<Vets> vetList = [];
  List<Vets> newVetList = [];
  List<Users> userList = [];

  Future<int> getUser() async{
    final questionsRef = FirebaseFirestore.instance.collection('user');
    final querySnapshot =await  questionsRef.get();
    final doc= querySnapshot.docs.length;
    return doc;
}
  Future<int> getVets() async{
    final questionsRef = FirebaseFirestore.instance.collection('vets');
    final querySnapshot =await  questionsRef.get();
    final doc= querySnapshot.docs.length;
    return doc;
}
  Future<int> getClinic() async{
    final questionsRef = FirebaseFirestore.instance.collection('Clinics');
    final querySnapshot =await  questionsRef.get();
    final doc= querySnapshot.docs.length;
    return doc;
}
  Future<List<Vets>> fetchDoctors() async {
    final questionsRef = FirebaseFirestore.instance.collection('vets').orderBy('AVGRATING', descending: true);
    final querySnapshot = await questionsRef.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Vets(
        cnic: data["cnic"],
        description: data["description"],
        email: data["email"],
        name: data["name"],
        phoneNumber: data["phone number"],
        profileImg: data["profileImg"],
        profileStatus: data["ProfileStatus"],
        profileType: data["ProfileType"],
        profileUnapprovalReason:data["ProfileUnapprovalReason"] ,
        qualification: data["qualification"],
        specialization: data["specialization"],

        uid: data["uid"],
        vetLiceance: data["VetLiceance"],
        year: data["year"],
      );
    }).toList();
  }
  Future<List<Vets>> fetchNewDoctors() async {
    final questionsRef = FirebaseFirestore.instance.collection('vets').where("ProfileStatus", isEqualTo: "UnApproved");
    final querySnapshot = await questionsRef.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Vets(
        cnic: data["cnic"],
        description: data["description"],
        email: data["email"],
        name: data["name"],
        phoneNumber: data["phoneNumber"],
        profileImg: data["profileImg"],
        profileStatus: data["profileStatus"],
        profileType: data["profileType"],
        profileUnapprovalReason:data["profileUnapprovalReason"] ,
        qualification: data["qualification"],
        specialization: data["specialization"],
        uid: data["uid"],
        vetLiceance: data["vetLiceance"],
        year: data["year"],
      );
    }).toList();
  }
  Future<List<Users>> fetchUsers() async {
    final questionsRef = FirebaseFirestore.instance.collection('user');
    final querySnapshot = await questionsRef.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Users(
        cNIC: data["CNIC"],
        email: data["email"],
        firstname: data["firstname"],
        lastname: data["lastname"],
        wallet: data["wallet"],
        phnumber: data["phnumber"],
        profileImg: data["profileImg"],
        uid: data["uid"],
      );
    }).toList();
  }
  Future<List<Bookings>> getBookings() async {
    final questionsRef = FirebaseFirestore.instance.collection('booking').where("userName",isEqualTo: "Accepted");
    final querySnapshot = await questionsRef.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Bookings(
        bookingEnd: data["bookingEnd"],
        bookingStart: data["bookingStart"],
        serviceDuration: data["serviceDuration"],
        serviceId: data["serviceId"],
        serviceName: data["serviceName"],
        servicePrice: data["servicePrice"],
        userEmail: data["userEmail"],
        userId: data["userId"],
        userName: data["userName"],
         userPhoneNumber: data["userPhoneNumber"],
      );
    }).toList();
  }