class Etapas {
  final double primera;
  final double segunda;
  final double tercera;

  const Etapas({required this.primera, required this.segunda, required this.tercera});

  factory Etapas.fromJson(Map<String, dynamic> data) {
    return Etapas(
      primera: data['primera'] ?? 0.0,
      segunda: data['segunda'] ?? 0.0,
      tercera: data['tercera'] ?? 0.0,
    );
  }
}