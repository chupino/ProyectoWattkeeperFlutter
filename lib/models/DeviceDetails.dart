import 'package:wattkeeperr/core/constants/urls.dart';

class DeviceDetails {
  int id;
  bool enabled;
  double? limiteConsumo;
  int etapaTamagochi;
  String nombre, descripcion, tamagochi, direccionMac;
  DeviceDetails({
    required this.etapaTamagochi,
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tamagochi,
    required this.direccionMac,
    required this.enabled,
    required this.limiteConsumo,
  });

  String getTamagochiImage() {
    return "${Urls.backendDjango}/media/$tamagochi";
  }

  String getTamagochiDynamicImage() {
    String tamagochiSinPng = tamagochi!.replaceAll(".png", "");
    return "${Urls.backendDjango}/media/${tamagochiSinPng}_$etapaTamagochi.png";
  }

  factory DeviceDetails.fromJson(Map<String, dynamic> data) {
    return DeviceDetails(
      id: data['id'] ?? 0,
      etapaTamagochi: data['etapa_tamagochi'],
      nombre: data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      tamagochi: data['tamagochi'] ?? '',
      enabled: data['limitacion']['enabled'] ?? false,
      direccionMac: data['direccion_mac'] ?? '',
      limiteConsumo: data['limitacion']['limite_consumo'] ?? 0.0,
    );
  }
}
