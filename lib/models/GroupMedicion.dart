import 'package:wattkeeperr/models/DeviceGroupMedicion.dart';
import 'package:wattkeeperr/models/medicion.dart';

class GroupMedicion {
  final List<Medicion> mediciones;
  final DeviceGroupMedicion device;

  const GroupMedicion({required this.device, required this.mediciones});

  factory GroupMedicion.fromJson(Map<String, dynamic> data) {
    return GroupMedicion(
        mediciones: (data["mediciones"] as List)
            .map((e) => Medicion.fromJson(e as Map<String, dynamic>))
            .toList(),
        device: DeviceGroupMedicion.fromJson(data["dispositivo"]));
  }
}
