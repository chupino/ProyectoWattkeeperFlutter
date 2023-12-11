import 'package:intl/intl.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Creador.dart';
import 'package:wattkeeperr/models/Payload.dart';

class NotificationDetails {
  final String id, direccionAccion, asunto, descripcion;
  final UserX destinatario;
  final UserX? remitente;
  final Payload? datosEnvio;
  final DateTime fechaEnvio;

  const NotificationDetails(
      {required this.id,
      required this.destinatario,
      this.remitente,
      this.datosEnvio,
      required this.asunto,
      required this.descripcion,
      required this.direccionAccion,
      required this.fechaEnvio});

  String getRequestJoinUrl() {
    return "${Urls.backendDjango}/api/$direccionAccion";
  }

  String formattedFechaEnvio() {
    final formatoFecha = DateFormat('d MMMM yyyy', 'es');
    return formatoFecha.format(fechaEnvio);
  }

  String formattedFechaEnvio2() {
    // Utiliza el paquete intl para formatear la fecha
    final formatoFecha = DateFormat('dd/MM/yyyy', 'es');
    return formatoFecha.format(fechaEnvio);
  }

  factory NotificationDetails.fromJson(Map<String, dynamic> data) {
    String fechaEnvioString = data["fecha_envio"];
    fechaEnvioString = fechaEnvioString.split(".").first;
    DateTime fechaEnvio = DateTime.parse(fechaEnvioString);

    return NotificationDetails(
      id: data["_id"] ?? "",
      destinatario: UserX.fromJson(data["destinatario"]),
      remitente: (data["remitente"] != null && data["remitente"].isNotEmpty)
          ? UserX.fromJson(data["remitente"])
          : null,
      datosEnvio:
          (data["datos_envio"] != null && data["datos_envio"].isNotEmpty)
              ? Payload.fromJson(data["datos_envio"])
              : null,
      asunto: data["asunto"] ?? "",
      descripcion: data["descripcion"] ?? "",
      direccionAccion: data["direccion_accion"] ?? "",
      fechaEnvio: fechaEnvio,
    );
  }
}
