class UserSettings {
  final bool alertasLimiteGrupo, alertaLimiteDispositivo, alertaRecompensa;

  const UserSettings(
      {required this.alertaLimiteDispositivo,
      required this.alertaRecompensa,
      required this.alertasLimiteGrupo});

  factory UserSettings.fromJson(Map<String, dynamic> data) {
    return UserSettings(
        alertaLimiteDispositivo: data['alerta_limite_dispositivo'],
        alertaRecompensa: data['alerta_recompensa'],
        alertasLimiteGrupo: data['alerta_limite_grupo']);
  }
}
