import 'package:flutter/material.dart';
import '../../../../model/vet.dart';
import '../../../../shared/components/header_bar.dart';
import 'VetsEdit_body_content.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/style/color.dart';

import 'Vets_Edit_notification_content.dart';

class VetsEditBody extends StatelessWidget {
  Vets vets;
   VetsEditBody({Key? key,required this.vets}) : super(key: key);

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
                  child: VetsEditBodyContent(vets: vets,),
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
