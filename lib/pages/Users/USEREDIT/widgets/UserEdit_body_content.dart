import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import '../../../../model/users_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/style/color.dart';
import '../../USERLIST/UserListScreen.dart';

class UserEditBodyContent extends StatelessWidget {
  Users users;

   UserEditBodyContent({Key? key,required this.users}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            EditUserForm(users: users,),
            const SizedBox(height: 5),
           ],
        ),
      ),
    );
  }
}


class EditUserForm extends StatefulWidget {
  Users users;
   EditUserForm({Key? key,required this.users}) : super(key: key);

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {

  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController phnumber;
  late TextEditingController email;
  late TextEditingController wallet;
  @override
  void initState() {
    setState(() {
      firstname = TextEditingController(text: widget.users.firstname);
      lastname = TextEditingController(text: widget.users.lastname);
      phnumber = TextEditingController(text: widget.users.phnumber);
      email = TextEditingController(text: widget.users.email);
      wallet = TextEditingController(text: widget.users.wallet.toString());

    });
    super.initState();

  }
  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    phnumber.dispose();
    email.dispose();
    wallet.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String userid=   widget.users.uid.toString();
    return SizedBox(
      width: double.infinity,
       child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("User Profile Edit",
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
            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(children: [
                    Expanded(child: CustomTextField(
                      obscure: false, hint: "First Name", controller: firstname,validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a First Name';
                      }
                      return null;
                    },
                    )),
                    Expanded(child: CustomTextField(
                      obscure: false,
                      hint: "Last Name",
                      controller: lastname,
                      validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Last Name';
                      }
                      return null;
                    },
                    )),

                  ],),
                  Row(children: [
                    Expanded(child: CustomTextField(
                      obscure: false,
                      hint: "Email",
                      controller: email,
                      validator: (value) {
                      // Regular expression for email validation
                      // This matches most common email formats, but it's not perfect
                      final emailRegex =
                      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null;
                    },
                    )),
                    Expanded(child: CustomTextField(
                      obscure: false,
                      hint: "Mobile Number:",
                      controller: phnumber,
                        validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Phone Number';
                      } else if (value.length != 11 || !value.startsWith('03')) {
                        return 'Phone Number should be 11 digits long and start with 03';
                      }
                      return null;
                    }
                    ))
                  ],),
           /*     Row(children: [
                    Expanded(child: CustomTextField(
                      obscure: false,
                      hint: "Wallet Balance",
                      controller: wallet,)),
                  ],),*/
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
                          if (_formKey.currentState!.validate()) {
                            int newWalletValue = int.tryParse(wallet.text) ??
                                0; // Parse the value of the wallet controller
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(userid)
                                .update({
                              'email': email.text,
                              'firstname': firstname.text,
                              'lastname': lastname.text,
                              'phnumber': phnumber.text,
                              'wallet': int.tryParse(wallet.text) ?? 0,
                            })
                                .then((value) => print('User updated'))
                                .catchError((error) =>
                                print('Failed to update user: $error'));
                            Users users = Users(
                              email: email.text,
                              firstname: firstname.text,
                              lastname: lastname.text,
                              phnumber: phnumber.text,
                              wallet: int.tryParse(wallet.text) ?? 0,
                            );
                            FirebaseFirestore.instance.collection("users").doc(
                                widget.users.uid).update(users.toJson());
                            await getValue();

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) {
                              return UserListScreen();
                            }));
                          }

                        },
                        child: Text("Edit Profile"),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  getValue() async {
    userList = await fetchUsers();
    setState(() {});
    print(userList);
  }
}


