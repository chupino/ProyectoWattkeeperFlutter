import 'package:intl/intl.dart';
import 'package:wattkeeperr/models/UserSettings.dart';

class User {
  int id;
  String nombres;
  String apellidos;
  String email;
  String fechaNacimiento;
  UserSettings configuracion;

  User(
      {required this.id,
      required this.nombres,
      required this.apellidos,
      required this.email,
      required this.fechaNacimiento,
      required this.configuracion
      });
  String getFormatedFecNac() {
    DateTime parsedFecNac = DateTime.parse(fechaNacimiento);
    return DateFormat('d MMMM y', 'es').format(parsedFecNac);
  }

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        id: data['id'],
        nombres: data['nombres'],
        apellidos: data['apellidos'],
        email: data['email'],
        fechaNacimiento: data['fecha_nacimiento'],
        configuracion: UserSettings.fromJson(data['configuracion'])
        );
        
  }
}
