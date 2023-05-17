import 'package:flutter/material.dart';
import '../../../../shared/components/header_bar.dart';
import 'ReScheduling_body_content.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/style/color.dart';


class ReSchedulingBody extends StatelessWidget {
  String vetID;
  String clinicID;
  String serviceID;
  String servicePrice;
  String bookingId;

  ReSchedulingBody({Key? key,required this.vetID, required this.clinicID, required this.serviceID, required this.servicePrice,required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.lightDarkColor,
      child: Column(
        children: [
          /// Header bar
          if (AppResponsive.isDesktop(context))...{
            const HeaderBar(),
          },

          /// Body
          Expanded(
            child: Row(
              children:  [
                /// Left side or body content
                 Expanded(
                  flex: 11,
                  child: ReSchedulingBodyContent(vetID: vetID, clinicID: clinicID, servicePrice: servicePrice, serviceID: serviceID, bookingId: bookingId,),
                ),

                if (AppResponsive.isDesktop(context))
                  const SizedBox(width: 20),

                /// Right side or notification content
                ],
            ),
          ),
        ],
      ),
    );
  }
}
