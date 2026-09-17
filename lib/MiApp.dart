import 'package:ejemplo/CreateProfileView.dart';
import 'package:ejemplo/HomeView.dart';
import 'package:ejemplo/LoginView.dart';
import 'package:ejemplo/OnBoardingView.dart';
import 'package:ejemplo/RegistroView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Miapp extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    String rutaInicial="/OnBoardingView";
    if(FirebaseAuth.instance.currentUser!=null){
      rutaInicial="/OnBoardingView";
    }


    return MaterialApp(
      title: "MI APP 1",
      routes: {
        "/LoginView" : (context) => LoginView(),
        "/HomeView" : (context) => HomeView(),
        "/RegistroView" : (context) => RegistroView(),
        "/OnBoardingView" : (context) => Onboardingview(),
        "/CreateProfileView" : (context) => Createprofileview(),
      },
      initialRoute: rutaInicial,
    );
  }
}
