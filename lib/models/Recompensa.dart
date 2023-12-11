class Recompensa {
  String recompensa;
  double limiteWatts;

  Recompensa({
    required this.recompensa,
    required this.limiteWatts,
  });

  factory Recompensa.fromJson(Map<String, dynamic> data) {
    return Recompensa(
      recompensa: data['recompensa'],
      limiteWatts: data['limite_watts'],
    );
  }
}
