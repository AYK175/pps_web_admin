/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/homeRoute";
  static const String profileRoute = "/profile";
  static const String recruitmentRoute = "/recruitment";
  static const String onBoardingRoute = "/onBoarding";
  static const String reportsRoute = "/reports";
  static const String calenderRoute = "/calender";
  static const String settingsRoute = "/settings";

}


 class RouteGenerator {
   static Route<dynamic> getRoute(RouteSettings routeSettings) {
     switch (routeSettings.name) {
       case Routes.homeRoute:
         return MaterialPageRoute(
             builder: (_) => HomePage()
         );

       case Routes.recruitmentRoute:
         return MaterialPageRoute(builder: (_) =>  profileRoute());

       default:
         return unDefinedRoute();
     }
   }

   static Route<dynamic> unDefinedRoute() {
     return MaterialPageRoute(
       builder: (_) =>
           Scaffold(
             appBar: AppBar(
               title: const Text('Route not Found'),
             ),
             body: const Center(
               child: Text('Route not Found'),
             ),
           ),
     );
   }
 }

*/
