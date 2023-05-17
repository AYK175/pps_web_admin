import 'package:flutter/material.dart';
import 'body_content.dart';
import '../../../shared/app_responsive/app_responsive.dart';
import '../../../shared/style/color.dart';
import '../../../shared/components/header_bar.dart';
import 'notification_content.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({Key? key}) : super(key: key);

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
                  flex: 1,
                  child: HomePageBodyContentNew(),
                ),

                if (AppResponsive.isDesktop(context))
                  const SizedBox(width: 20),

                /// Right side or notification content
              /*  if(AppResponsive.isDesktop(context) )...{
                  const Expanded(
                    flex: 4,
                    child: NotificationContent(),
                  ),
                },*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
