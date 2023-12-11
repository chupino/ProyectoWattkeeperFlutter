class DeviceExpensive {
  final String nombre;
  final double consumo;

  const DeviceExpensive({required this.consumo, required this.nombre});

  factory DeviceExpensive.fromJson(Map<String, dynamic> data) {
    return DeviceExpensive(
        consumo: data["consumo"], nombre: data["dispositivo"]);
  }
}
