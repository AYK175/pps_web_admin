import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pps_web_admin/model/users_model.dart';
import 'package:pps_web_admin/model/vet.dart';

const kPrimaryColor = Color(0xDF1A3B6A);
const kPrimaryLightColor = Color(0xFFE6E7FF);

const double defaultPadding = 16.0;

  // final user= FirebaseAuth.instance.currentUser!;
  int userCount = 0;
  int vetCount = 0;
  int clinicCount = 0;
  int bookingCount = 0;
  List<Vets> vetList = [];
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
  Future<int> getBookings() async{
    final questionsRef = FirebaseFirestore.instance.collection('booking');
    final querySnapshot =await  questionsRef.get();
    final doc= querySnapshot.docs.length;
    return doc;
}
  Future<List<Vets>> fetchDoctors() async {
    final questionsRef = FirebaseFirestore.instance.collection('vets');
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
        profileStatus: data["profileStatus"],
        profileType: data["ProfileType"],
        profileUnapprovalReason: data["ProfileUnapprovalReason"] ,
        qualification: data["qualification"],
        specialization: data["specialization"],
        uid: data["uid"],
        vetLiceance: data["VetLiceance"],
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