import 'package:wattkeeperr/core/constants/urls.dart';

class Device {
  int id, usuario;
  double acumuladoWatts;
  double acumuladoWattsTotal;
  double voltaje;
  double amperaje;
  double watts;
  double? limiteConsumo;
  String? tamagochi;
  int etapaTamagochi;
  String nombre, descripcion, direccionMac;
  DateTime? fechaMedicion, fechaRegistro;

  Device({
    required this.etapaTamagochi,
    required this.id,
    required this.usuario,
    required this.nombre,
    required this.acumuladoWatts,
    required this.acumuladoWattsTotal,
    required this.amperaje,
    required this.watts,
    required this.voltaje,
    required this.descripcion,
    this.tamagochi,
    this.fechaMedicion,
    this.fechaRegistro,
    required this.direccionMac,
    this.limiteConsumo,
  });

  String getTamagochiImage() {
    return "${Urls.backendDjango}/media/$tamagochi";
  }

  String getTamagochiDynamicImage() {
    String tamagochiSinPng = tamagochi!.replaceAll(".png", "");
    return "${Urls.backendDjango}/media/${tamagochiSinPng}_$etapaTamagochi.png";
  }

  factory Device.fromJson(Map<String, dynamic> data) {
    dynamic limiteConsumoData = data['limite_consumo'];
    return Device(
        id: data['id'] ?? 1,
        etapaTamagochi: data['etapa_tamagochi'],
        usuario: data['usuario'] ?? 1,
        nombre: data['nombre'] ?? "",
        descripcion: data['descripcion'] ?? "",
        tamagochi: data['tamagochi'] ?? "",
        direccionMac: data['direccion_mac'] ?? "",
        limiteConsumo: limiteConsumoData is String
            ? double.tryParse(limiteConsumoData) ?? 0.0
            : limiteConsumoData ?? 0.0,
        acumuladoWatts: (data['datos_consumo']['acumulado_watts']) ?? 0.0,
        amperaje: (data['datos_consumo']['amperaje']) ?? 0.0,
        voltaje: (data['datos_consumo']['voltaje']) ?? 0.0,
        watts: (data['datos_consumo']['watts']) ?? 0.0,
        fechaMedicion: parseDateTime(data['datos_consumo']['fecha_medicion']),
        fechaRegistro: parseDateTime(data['datos_consumo']['fecha_registro']),
        acumuladoWattsTotal: data["acumulado_watts_total"]);
  }
  String formattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String calculateTimeDifference(DateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "Hace ${difference.inSeconds} segundos";
    } else if (difference.inMinutes < 60) {
      return "Hace ${difference.inMinutes} minutos";
    } else if (difference.inHours < 24) {
      return "Hace ${difference.inHours} horas";
    } else {
      return "Hace ${difference.inDays} días";
    }
  }

  static DateTime? parseDateTime(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
