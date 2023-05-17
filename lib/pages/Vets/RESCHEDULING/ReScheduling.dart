import 'package:flutter/material.dart';
import 'package:pps_web_admin/pages/HomePageNew/widgets/dashboard_body.dart';
import 'package:pps_web_admin/pages/Vets/RESCHEDULING/widgets/ReScheduling_body.dart';
import 'package:pps_web_admin/pages/Vets/VETSLIST/widgets/VetsList_body.dart';
import '../../home/widgets/dashboard_body.dart';
import '../../home/widgets/header_bar.dart';
import '../../../shared/components/side_menu_widget.dart';
import '../../../shared/style/color.dart';
import '../../../shared/app_responsive/app_responsive.dart';

class ReSchedulingScreen extends StatelessWidget {
  String vetID;
  String clinicID;
  String serviceID;
  String servicePrice;
  String bookingId;

  ReSchedulingScreen({Key? key,required this.vetID, required this.clinicID, required this.serviceID, required this.servicePrice,required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void controlMenu() {
      if (!_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openDrawer();
      }
    }

    return Scaffold(
      backgroundColor: ColorManager.darkColor,
      drawer: const Padding(
        padding: EdgeInsets.only(top: 18.0),
        child: SideMenuWidget(),
      ),
      key: _scaffoldKey,
      appBar: (!AppResponsive.isDesktop(context) && !AppResponsive.isTablet(context)) ?AppBar(
        backgroundColor: ColorManager.lightDarkColor,
        elevation: 0,
      ):null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Side menu
            if (AppResponsive.isDesktop(context))
              const Expanded(
                flex: 2,
                child: SideMenuWidget(),
              ),
            /// Main content
             Expanded(
              flex: 9,
              child: ReSchedulingBody(vetID: vetID, clinicID: clinicID, servicePrice: servicePrice, serviceID: serviceID, bookingId: bookingId,),

            )
          ],
        ),
      ),
    );
  }
}
