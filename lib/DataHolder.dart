import 'FbObjects/Perfil.dart';

class Dataholder {
  Dataholder._();

  static final Dataholder instance = Dataholder._();

  late Perfil perfilUsuario;

  //Variables compartidas del boton bar
  bool blNotificacionesBadge=true;
  String sMessagesBadgeText="";
  int iBotBarIndex=0;


}