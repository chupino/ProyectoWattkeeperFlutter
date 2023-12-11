import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Creador.dart';

class Group {
  int id;
  UserX creador;
  String nombre, descripcion, tamagochi;
  double? limiteConsumo;
  List usuarios;
  List dispositivos;

  Group(
      {required this.tamagochi,
      required this.limiteConsumo,
      required this.id,
      required this.creador,
      required this.nombre,
      required this.descripcion,
      required this.dispositivos,
      required this.usuarios});
  String getTamagochiImage() {
    return "${Urls.backendDjango}/media/tamagochi_dispositivos/$tamagochi";
  }

  factory Group.fromJson(Map<String, dynamic> data) {
    return Group(
      id: data["id"],
      creador: UserX.fromJson(data["creador"]),
      nombre: data["nombre"],
      descripcion: data["descripcion"],
      dispositivos: data["dispositivos"],
      usuarios: data["usuarios"],
      tamagochi: data["tamagochi"],
      limiteConsumo: data["limite_consumo"] ?? 0,
    );
  }
}
