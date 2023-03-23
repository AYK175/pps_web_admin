import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pps_web_admin/Screens/Doctors/doctor_screen.dart';
import 'package:pps_web_admin/components/widget/custom_textfield.dart';
import 'package:pps_web_admin/components/widget/dashboard_name.dart';
import 'package:pps_web_admin/components/widget/drawer.dart';
import 'package:pps_web_admin/constants.dart';
import 'package:pps_web_admin/model/users_model.dart';
import 'package:pps_web_admin/model/vet.dart';

class DoctorEditScreen extends StatefulWidget {
  Vets vets;
   DoctorEditScreen({Key? key,required this.vets}) : super(key: key);

  @override
  State<DoctorEditScreen> createState() => _DoctorEditScreenState();
}

class _DoctorEditScreenState extends State<DoctorEditScreen> {
  late TextEditingController name;
  late TextEditingController profileStatus;
  late TextEditingController profileType;
  late TextEditingController profileUnapprovalReason;
  late TextEditingController vetLiceance;
  late TextEditingController cnic;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController profileImg;
  late TextEditingController qualification;
  late TextEditingController specialization;
  late TextEditingController year;
  @override
  void initState() {

    setState(() {
      name=TextEditingController(text: widget.vets.name);
      profileStatus=TextEditingController(text: widget.vets.profileStatus);
      profileType=TextEditingController(text: widget.vets.profileType);
      profileUnapprovalReason=TextEditingController(text: widget.vets.profileUnapprovalReason);
      vetLiceance=TextEditingController(text: widget.vets.vetLiceance);
      cnic=TextEditingController(text: widget.vets.cnic);
      email=TextEditingController(text: widget.vets.email);
      phoneNumber=TextEditingController(text: widget.vets.phoneNumber);
      qualification=TextEditingController(text: widget.vets.qualification);
      specialization=TextEditingController(text: widget.vets.specialization);
      year=TextEditingController(text: widget.vets.year);
      });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomDrawer(),
          SizedBox(
            width: 0.02.sw,
          ),
          Expanded(
              flex: 8,
              child: Column(
                children: [
              DashboardName(title: "Edit Doctors",),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "Name",controller: name,)),
              Expanded(child: CustomTextField(obscure: false,hint: "profile Status",controller: profileStatus,))
            ],),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "profile Type",controller: profileType,)),
              Expanded(child: CustomTextField(obscure: false,hint: "profile Unapproval Reason",controller: profileUnapprovalReason,))
            ],),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "Vet Liceance Number",controller: vetLiceance,)),
              Expanded(child: CustomTextField(obscure: false,hint: "CNIC",controller: cnic,))
            ],),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "Email",controller: email,)),
              Expanded(child: CustomTextField(obscure: false,hint: "Phone Number",controller: phoneNumber,)),

            ],),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "qualification",controller: qualification,))
            ],),
            Row(children: [
              Expanded(child: CustomTextField(obscure: false,hint: "Specialization",controller: specialization,)),
              Expanded(child: CustomTextField(obscure: false,hint: "Experience",controller: year,))
            ],),
                  Center(child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        )
                    ),
                    onPressed: () async {
                      Vets vets=Vets(
                        cnic: cnic.text,
                        description: widget.vets.description,
                        email: email.text,
                        name: name.text,
                        phoneNumber: phoneNumber.text,
                        profileImg: widget.vets.profileImg,
                        profileStatus: profileStatus.text,
                        profileType: profileType.text,
                        profileUnapprovalReason:profileUnapprovalReason.text,
                        qualification:qualification.text,
                        specialization: specialization.text,
                        uid: widget.vets.uid,
                        vetLiceance: vetLiceance.text,
                        year: year.text,
                      );
                      FirebaseFirestore.instance.collection("vets").doc(widget.vets.uid).update(vets.toJson());
                      await getValue();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return DoctorScreen();
                          }));
                    }, child: Text("Edit Profile"),
                  ),),
                  SizedBox(
                    width: 0.02.sw,
                    height: 0.1.sh,
                  ),

          ],)),
        ],
      )
    );
  }
  getValue() async {
    userCount = await getUser();
    vetCount = await getVets();
    clinicCount = await getClinic();
    bookingCount = await getBookings();
    vetList   =await fetchDoctors();
    userList=await fetchUsers();
    setState(() {});
    print(userList);
  }
}
