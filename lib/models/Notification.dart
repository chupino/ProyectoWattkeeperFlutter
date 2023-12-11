import 'package:intl/intl.dart';

class NotificationModel {
  final String id;
  final String asunto;
  final String descripcion;
  final DateTime fechaEnvio;

  const NotificationModel(
      {
      required this.id,
      required this.asunto,
      required this.descripcion,
      required this.fechaEnvio});

  String formattedFechaEnvio() {
    final formatoFecha = DateFormat('d MMMM yyyy', 'es');
    return formatoFecha.format(fechaEnvio);
  }

  String formattedFechaEnvio2() {
    // Utiliza el paquete intl para formatear la fecha
    final formatoFecha = DateFormat('dd/MM/yyyy', 'es');
    return formatoFecha.format(fechaEnvio);
  }

  factory NotificationModel.fromJson(Map<String, dynamic> data) {
    String fechaEnvioString = data["fecha_envio"];
    fechaEnvioString = fechaEnvioString.split(".").first;
    DateTime fechaEnvio = DateTime.parse(fechaEnvioString);
    return NotificationModel(
        id: data["_id"],
        asunto: data["asunto"],
        descripcion: data["descripcion"],
        fechaEnvio: fechaEnvio);
  }
}
