import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{
  var faInstance=FirebaseAuth.instance;
  late BuildContext miContext;
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void funClickLogin() async{
    String usuario = userController.text;
    String password = passwordController.text;
    try {
      await faInstance.signInWithEmailAndPassword(
          email: usuario,
          password: password
      );
      Navigator.popAndPushNamed(miContext, "/OnBoardingView");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void funClickRegistro(){
    print("--->>>> REGISTRO PRESIONADO");
    Navigator.pushNamed(miContext, "/RegistroView");
  }

  @override
  Widget build(BuildContext context) {
    miContext=context;
    TextStyle estilo=TextStyle(fontSize: 50, backgroundColor: Colors.redAccent);

    return Scaffold(
      appBar: AppBar(title: Text("MI APP 1"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("LOGIN", style: estilo),
          TextField(controller: userController, decoration: InputDecoration(hintText: "Usuario"),),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: "Contraseña"),
          ),
          Row(
            children: [
              TextButton(onPressed: funClickLogin, child: Text("Login"),),
              TextButton(onPressed: funClickRegistro, child: Text("Registrarse"),),
            ],
          ),
        ],
      ),
    );
  }
}
