import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatelessWidget {
  final FirebaseAuth faInstance = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  late BuildContext miContext;

  RegistroView({super.key});

  void funRegistrado() async {
    String email = emailController.text;
    String password = passwordController.text;
    if(repasswordController.text != passwordController.text){
      print("CONTRASEÑAS NO COINCIDEN");
    }
    else {
      try {
        final credential = await faInstance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if(credential.user!=null){
          Navigator.popAndPushNamed(miContext, '/OnBoardingView');
        }
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('La contraseña es demasiado débil.');
        } else if (e.code == 'email-already-in-use') {
          print('Ya existe una cuenta con este correo.');
        }
      }
    }
  }

  void funClickLogin() {
    Navigator.popAndPushNamed(miContext, '/LoginView');
  }

  @override
  Widget build(BuildContext context) {
    miContext = context;
    TextStyle estilo = TextStyle(fontSize: 50, backgroundColor: Colors.redAccent);

    return Scaffold(
      appBar: AppBar(title: Text('MI APP 1')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('REGISTRO', style: estilo),
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Contraseña'),
          ),
          TextField(
            controller: repasswordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Repetir Contraseña'),
          ),
          Row(
            children: [
              TextButton(onPressed: funClickLogin, child: Text('Login')),
              TextButton(onPressed: funRegistrado, child: Text('Aceptar')),
            ],
          ),
        ],
      ),
    );
  }
}
