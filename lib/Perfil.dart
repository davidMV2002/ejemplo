import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  final String? nombre;
  final int? edad;
  final double? altura;

  Perfil({this.nombre, this.edad,this.altura});

  factory Perfil.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return Perfil(
      nombre: data?['nombre'],
      edad: data?['edad'],
      altura: data?['altura'],
    );
  }


}