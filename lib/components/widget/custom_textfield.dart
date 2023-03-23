import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  String hint;
  bool obscure;
  Widget? prefix;
  bool? enableUrdu=false;
  Widget? suffix;
  TextEditingController? controller;
   CustomTextField({Key? key,required this.hint,
    required this.obscure,
     this.enableUrdu,
     this.controller,
     this.prefix,
     this.suffix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(hint,textAlign:enableUrdu==true?TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: "Nastaleeq"),),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextField(
            controller: controller,
            style: TextStyle(fontFamily: "Nastaleeq"),
            textAlign: enableUrdu==true?TextAlign.right:TextAlign.left,
            obscureText: obscure,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              suffixIcon: suffix,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
              hintTextDirection:enableUrdu==true?TextDirection.rtl:TextDirection.ltr,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: prefix,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}

