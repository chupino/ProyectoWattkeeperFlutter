import 'package:wattkeeperr/models/onboardContent.dart';

class OnBoardData{
  List<OnboardContent> contents = [
  OnboardContent(
    image: "assets/animations/welcome.json",
    text: "Bienvenido",
    descripcion: "¡Bienvenido a Wattkeeper! Únete a nosotros",
  ),
  OnboardContent(
    image: "assets/animations/Ahorro.json",
    text: "No Malgastes",
    descripcion:
        "Visualiza y controla tu consumo diario para un estilo de vida sostenible.",
  ),
  OnboardContent(
    image: "assets/animations/Alertas.json",
    text: "Alertas y Monitoreo",
    descripcion:
        "Recibe alertas instantáneas para optimizar tu uso de energía en nuestro hotel.",
  ),
  OnboardContent(
    image: "assets/animations/Aspa2.json",
    text: "Energía Sostenible",
    descripcion:
        "Gestionamos el consumo y ofrecemos recompensas exclusivas para huéspedes comprometidos.",
  ),
];
}