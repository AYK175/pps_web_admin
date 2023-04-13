import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../model/vet.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import '../../VETSLIST/VetsLIstScreen.dart';
import 'Vets_Edit_notification_content.dart';

class VetsEditBodyContent extends StatelessWidget {
  Vets vets;

   VetsEditBodyContent({Key? key,required this.vets}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            TableOfEmployee(vets: vets,),
            const SizedBox(height: 5),
           ],
        ),
      ),
    );
  }
}


class TableOfEmployee extends StatefulWidget {
  Vets vets;
   TableOfEmployee({Key? key,required this.vets}) : super(key: key);

  @override
  State<TableOfEmployee> createState() => _TableOfEmployeeState();
}

class _TableOfEmployeeState extends State<TableOfEmployee> {

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
      name = TextEditingController(text: widget.vets.name);
      profileStatus = TextEditingController(text: widget.vets.profileStatus);
      profileType = TextEditingController(text: widget.vets.profileType);
      profileUnapprovalReason =
          TextEditingController(text: widget.vets.profileUnapprovalReason);
      vetLiceance = TextEditingController(text: widget.vets.vetLiceance);
      cnic = TextEditingController(text: widget.vets.cnic);
      email = TextEditingController(text: widget.vets.email);
      phoneNumber = TextEditingController(text: widget.vets.phoneNumber);
      qualification = TextEditingController(text: widget.vets.qualification);
      specialization = TextEditingController(text: widget.vets.specialization);
      year = TextEditingController(text: widget.vets.year);
    });
    super.initState();
  }

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
              const Text(
                'Vet Edit',
                style: TextStyle(color: ColorManager.orangeColor, fontSize: 20),
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

                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false, hint: "Name", controller: name,)),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(top:16.0),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Profile Status',
                        labelStyle: TextStyle(fontFamily: "Nastaleeq",color: ColorManager.orangeColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color: ColorManager.orangeColor)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.redColor)),
                        contentPadding: EdgeInsets.symmetric(vertical: 5.3, horizontal: 10),
                      ),

                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: profileStatus.text,
                          onChanged: (String? value) {
                            setState(() {
                              profileStatus.text = value!;
                            });
                          },
                          items: <String>['Approved', 'Unapproved'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  value,
                                  style: TextStyle(fontFamily: "Nastaleeq",color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  )
                  )
                ],),
                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Profile Type",
                    controller: profileType,)),
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Profile Disapproval Reason",
                    controller: profileUnapprovalReason,))
                ],),
                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Vet Licence",
                    controller: vetLiceance,)),
                  Expanded(child: CustomTextField(
                    obscure: false, hint: "C N I C", controller: cnic,))
                ],),
                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false, hint: "Email", controller: email,))
                ],),
                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Phone Number",
                    controller: phoneNumber,)),
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Qualification",
                    controller: qualification,))
                ],),
                Row(children: [
                  Expanded(child: CustomTextField(
                    obscure: false,
                    hint: "Specialization",
                    controller: specialization,)),
                  Expanded(child: CustomTextField(
                    obscure: false, hint: "Year", controller: year,))
                ],),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )

                          ),
                          backgroundColor:
                      MaterialStateProperty.all<Color>(ColorManager.orangeColor),
                      minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),

                    ),
                      onPressed: () async {
                        Vets vets = Vets(
                          cnic: cnic.text,
                          description: widget.vets.description,
                          email: email.text,
                          name: name.text,
                          phoneNumber: phoneNumber.text,
                          profileImg: widget.vets.profileImg,
                          profileStatus: profileStatus.text,
                          profileType: profileType.text,
                          profileUnapprovalReason: profileUnapprovalReason.text,
                          qualification: qualification.text,
                          specialization: specialization.text,
                          uid: widget.vets.uid,
                          vetLiceance: vetLiceance.text,
                          year: year.text,
                        );
                        FirebaseFirestore.instance.collection("vets").doc(
                            widget.vets.uid).update(vets.toJson());
                        await getValue();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return VetsListScreen();
                            }));
                      }, child: Text("Edit Profile"),
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

  getValue() async {
    vetList = await fetchDoctors();
    newVetList = await fetchNewDoctors();
    setState(() {});
    print(userList);
  }
}



