import 'package:intl/intl.dart';

class MedicionGrafico {
  final DateTime fechaDia;
  double consumo;

  MedicionGrafico({required this.consumo, required this.fechaDia});

  static DateTime parseDateString(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error al parsear la cadena de fecha: $e");
      return DateTime.now();
    }
  }

  String getFormattedFechaDia() {
    final DateFormat formatter = DateFormat('E d', 'es');
    return formatter.format(fechaDia);
  }

  factory MedicionGrafico.fromJson(Map<String, dynamic> data) {
    return MedicionGrafico(
        consumo: data["total_watts"], fechaDia: parseDateString(data["_id"]));
  }
}
