class DeviceGroupMedicion {
  final int id;
  final double? limiteConsumo;
  final String nombre, direccionMac;

  const DeviceGroupMedicion(
      {required this.id,
      required this.limiteConsumo,
      required this.direccionMac,
      required this.nombre});

  factory DeviceGroupMedicion.fromJson(Map<String, dynamic> data) {
    return DeviceGroupMedicion(
        id: data["id"],
        limiteConsumo: data["limite_consumo"],
        direccionMac: data["direccion_mac"],
        nombre: data["nombre"]);
  }
}
