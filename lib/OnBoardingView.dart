import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Perfil.dart';

class Onboardingview extends StatefulWidget{
  const Onboardingview({super.key});

  @override
  State<Onboardingview> createState() => _Onboardingview();
}

class _Onboardingview extends State<Onboardingview>{
  FirebaseFirestore db = FirebaseFirestore.instance;
  int _idProgress=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarRecursos();
  }

  void cargarRecursos() async{
    await recursos1();
    setState(() {
      _idProgress=20;
    });

    await recursos2();
    setState(() {
      _idProgress=80;
    });

    await recursos3();
    setState(() {
      _idProgress=100;
    });

    if(FirebaseAuth.instance.currentUser==null){
      Navigator.popAndPushNamed(context, "/LoginView");
    }
    else{
      String uid=FirebaseAuth.instance.currentUser!.uid;
      print("EL UID DEL USUARIO LOGUEADO ES" + uid);
      final docRef = db.collection("Perfiles").doc(uid)
        .withConverter(
          fromFirestore: Perfil.fromFirestore,
          toFirestore: (Perfil perfil, _) => perfil.toFirestore())
      ;
      docRef.get().then(
            (DocumentSnapshot<Perfil> doc) {
              if(doc.data()==null){
                Navigator.popAndPushNamed(context, "/CreateProfileView");
                return;
              }
              final perfil = doc.data()!;
              print("LA ALTURA DEL USUARIO ES: ${perfil.altura}");

              Navigator.popAndPushNamed(context, "/HomeView");
            },
        onError: (e) => print("ERROR!!!"),
      );
    }
  }

  Future<void>recursos1() async{
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void>recursos2() async{
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void>recursos3() async{
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.network('https://i.gifer.com/ZZ5H.gif'),
            Padding(padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: CircularProgressIndicator(),
            ),
            //LinearProgressIndicator(value: 0.4,),
            Text("$_idProgress%")
          ],
        ),
      )
    );
  }
}
