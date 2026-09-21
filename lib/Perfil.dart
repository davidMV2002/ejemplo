import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  final String? nombre;
  final int? edad;
  final double? altura;
  String? uid;


  Perfil({this.uid,this.nombre, this.edad, this.altura});

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Perfil(
      uid:snapshot.id,
      nombre: data?['name'] as String?,
      edad: (data?['edad'] as num?)?.toInt(),
      altura: (data?['altura'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "name": nombre,
      if (edad != null) "edad": edad,
      if (altura != null) "altura": altura,
    };
  }

}