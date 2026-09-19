import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Createprofileview extends StatelessWidget{
  late BuildContext miContext;
  final TextEditingController altura = TextEditingController();
  final TextEditingController edad = TextEditingController();
  final TextEditingController nombre = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void funClickCancel(){
    FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(miContext, "/LoginView");
  }

  void funClickAcept() async{
    if(edad.text.isNotEmpty && altura.text.isNotEmpty && nombre.text.isNotEmpty) {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      //final perfil =
      await db.collection("Perfiles").doc(uid).set({
        "Altura": altura.text,
        "Edad": edad.text,
        "Nombre": nombre.text,
      });

      Navigator.popAndPushNamed(miContext, "/HomeView");
    }
  }

  @override
  Widget build(BuildContext context){
    miContext=context;
    TextStyle estilo = TextStyle(fontSize: 50, backgroundColor: Colors.redAccent);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('CREA TU PERFIL', style: estilo,),
          TextField(controller: altura,
            decoration: InputDecoration(hintText: 'Altura'),),
          TextField(controller: edad,
            decoration: InputDecoration(hintText: 'Edad'),),
          TextField(controller: nombre,
            decoration: InputDecoration(hintText: 'Nombre'),),
          Row(
            children: [
              TextButton(onPressed: funClickCancel, child: Text('Cancelar')),
              TextButton(onPressed: funClickAcept, child: Text('Aceptar')),
            ],
          )
        ],

      ),
    );
  }
}
