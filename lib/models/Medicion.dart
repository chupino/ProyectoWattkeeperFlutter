import 'package:intl/intl.dart';

class Medicion {
  final String id, direccionMac;
  final double acumuladoWatts, voltaje, amperaje, watts;
  final DateTime? fechaMedicion;

  Medicion(
      {
      required this.id,
      required this.direccionMac,
      required this.acumuladoWatts,
      required this.voltaje,
      required this.amperaje,
      required this.watts,
      this.fechaMedicion});

  static DateTime? parseDateTime(String? dateString) {
    if (dateString == null) return null;
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getFormatedDate() {
    if (fechaMedicion != null) {
      return DateFormat('EEE dd MMM HH:mm', 'es').format(fechaMedicion!);
    } else {
      return '';
    }
  }

  factory Medicion.fromJson(Map<String, dynamic> data) {
    return Medicion(
      id: data["_id"] ?? '0',
      direccionMac: data["dispositivo_mac"],
      acumuladoWatts: data["acumulado_watts"],
      voltaje: data["voltaje"],
      amperaje: data["amperaje"],
      watts: data["watts"],
      fechaMedicion: parseDateTime(data['fecha_medicion']),
    );
  }
}
