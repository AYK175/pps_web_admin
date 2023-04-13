import 'package:flutter/material.dart';
import '../../../../shared/components/header_bar.dart';
import 'NewVetslist_body_content.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/style/color.dart';

import 'NewVetsList_notification_content.dart';

class NewVetsListBody extends StatelessWidget {
  const NewVetsListBody({Key? key}) : super(key: key);

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
                const Expanded(
                  flex: 11,
                  child: NewVetsListBodyContent(),
                ),

                if (AppResponsive.isDesktop(context))
                  const SizedBox(width: 20),

                /// Right side or notification content
                if(AppResponsive.isDesktop(context) )...{
                  const Expanded(
                    flex: 4,
                    child: NewVetsListNotificationContent(),
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }
}
