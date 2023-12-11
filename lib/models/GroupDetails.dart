import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Creador.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/Recompensa.dart';

class GroupDetails {
  int id;
  UserX creador;
  List<UserX> usuarios;
  String nombre, descripcion;
  List<Device> dispositivos;
  double? limiteConsumo;
  String? tamagochi;
  int etapaTamagochi;
  List<Recompensa> recompensas;
  bool ahorroEnabled;
  double? acumuladoWattsTotal;
  double? acumuladoWattsTotalPeriodoActual;

  GroupDetails({
    required this.id,
    required this.ahorroEnabled,
    required this.creador,
    required this.usuarios,
    required this.nombre,
    required this.descripcion,
    required this.dispositivos,
    required this.limiteConsumo,
    required this.etapaTamagochi,
    this.tamagochi,
    this.acumuladoWattsTotalPeriodoActual,
    required this.acumuladoWattsTotal,
    required this.recompensas,
  });

  String getTamagochiImage() {
    return "${Urls.backendDjango}/media/$tamagochi";
  }

  String getTamagochiDynamicImage() {
    String tamagochiSinPng = tamagochi!.replaceAll(".png", "");
    return "${Urls.backendDjango}/media/${tamagochiSinPng}_$etapaTamagochi.png";
  }

  factory GroupDetails.fromJson(Map<String, dynamic> data) {
    return GroupDetails(
      id: data['id'],
      acumuladoWattsTotal: (data['ahorro']['acumulado_watts_total'] ?? 0),
      ahorroEnabled: data['ahorro']['enabled'],
      creador: UserX.fromJson(data['creador']),
      usuarios:
          (data["usuarios"] as List).map((e) => UserX.fromJson(e)).toList(),
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      etapaTamagochi: data['etapa_tamagochi'],
      dispositivos: data['dispositivos'] != null
          ? (data['dispositivos'] as List)
              .map((element) => Device.fromJson(element))
              .toList()
          : [],
      acumuladoWattsTotalPeriodoActual: data[''],
      recompensas: data['ahorro']['recompensas'] != null
          ? (data['ahorro']['recompensas'] as List)
              .map((element) => Recompensa.fromJson(element))
              .toList()
          : [],
      limiteConsumo: (data['ahorro']['limite_consumo'] ?? 0.0),
      tamagochi: data['tamagochi'],
    );
  }
}
