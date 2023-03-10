import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Screens/HomePage/home.dart';
import 'Screens/Login/login_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context, snapshot){
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginScreen();
        }
      },
      )
    );

  }
}
