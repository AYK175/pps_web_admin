import 'package:flutter/material.dart';
import '../../../../model/vet.dart';
import '../../../../shared/components/header_bar.dart';
import '../../../HomePageNew/widgets/notification_content.dart';
import 'ReportsProfile_body_content.dart';
import '../../../../shared/app_responsive/app_responsive.dart';
import '../../../../shared/style/color.dart';

class ReportsBody extends StatelessWidget {

  ReportsBody({Key? key,}) : super(key: key);

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
                  child: ReportsBodyContent(),
                ),

                if (AppResponsive.isDesktop(context))
                  const SizedBox(width: 20),

                /// Right side or notification content
                if(AppResponsive.isDesktop(context) )...{
                  const Expanded(
                    flex: 4,
                    child: NotificationContent(),
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
