import 'package:flutter/material.dart';
import '../../model/list_item_model.dart';
import '../style/color.dart';


class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final String? text;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    this.onTap,
    this.text,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
                if (text != null) Text(text!, overflow: TextOverflow.ellipsis),
              ],
            ),
            Positioned(
              top: -8,
              right: -5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorManager.primaryColor),
                alignment: Alignment.center,
                child: Text(
                  '$notificationCount',
                  style: const TextStyle(
                    color: ColorManager.white,
                    fontSize: 11,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




/*
class ListItemWidget extends StatelessWidget {
  final ListItemModel itemModel;
  const ListItemWidget({Key? key, required this.itemModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Icon(itemModel.icon,size: 20 ,),
      title: Text(
        itemModel.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorManager.white,
        ),
      ),
      onTap: () {
          Navigator.pushNamed(context, itemModel.routes);
      },
    );
  }
}
*/



Widget bodyTableTitle({required String title}) {
  return Expanded(
    flex: 2,
    child: Text(
      title,
      style: const TextStyle(color: ColorManager.white),
    ),
  );
}

Widget headTableTitle({required String title}) => Expanded(
  flex: 2,
  child: Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorManager.white,
    ),
  ),
);

Widget completeStar(double numOfStars) => Row(
  children: [
    ...List.generate(
        numOfStars.toInt(),
            (index) => const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.star,size: 15),
        )),
    ...List.generate(
      numOfStars.round() - numOfStars.floor(),
          (index) => const Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: Icon(Icons.star_half,size: 15),
      ),
    )
  ],
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 3.0),
  child: Divider(color: ColorManager.white.withOpacity(0.2)),
);

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Widget? prefix;
  final bool? enableUrdu;
  final Widget? suffix;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Added validator parameter

  CustomTextField({
    Key? key,
    required this.hint,
    required this.obscure,
    this.enableUrdu,
    this.controller,
    this.prefix,
    this.suffix,
    this.validator, // Added validator parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        title: Text(
          hint,
          textAlign: enableUrdu == true ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontFamily: "Nastaleeq",
            color: ColorManager.orangeColor,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextFormField( // Replaced TextField with TextFormField
            controller: controller,
            style: TextStyle(fontFamily: "Nastaleeq", color: Colors.white),
            textAlign: enableUrdu == true ? TextAlign.right : TextAlign.left,
            obscureText: obscure,
            cursorColor: Colors.white,
            validator: validator, // Added validator
            decoration: InputDecoration(
              suffixIcon: suffix,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: ColorManager.orangeColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.redColor),
              ),
              hintTextDirection: enableUrdu == true
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              prefixIcon: prefix,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}

/*
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
        title: Text(hint,textAlign:enableUrdu==true?TextAlign.right:TextAlign.left,style: TextStyle(fontFamily: "Nastaleeq",color: ColorManager.orangeColor),),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextField(
            controller: controller,
            style: TextStyle(fontFamily: "Nastaleeq",color: Colors.white),
            textAlign: enableUrdu==true?TextAlign.right:TextAlign.left,
            obscureText: obscure,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              suffixIcon: suffix,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),borderSide: BorderSide(color: ColorManager.orangeColor)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.redColor)),
              hintTextDirection:enableUrdu==true?TextDirection.rtl:TextDirection.ltr,
              prefixIcon: prefix,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }
}
*/
