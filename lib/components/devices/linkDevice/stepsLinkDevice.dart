import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class StepsLinkDevice {
  static List<EasyStep> steps = [
    const EasyStep(
      icon: Icon(Icons.scanner),
      title: "Escaneo",
      lineText: '',
    ),
    const EasyStep(
      icon: Icon(Icons.info),
      title: "Informacion",
      lineText: '',
    ),
    const EasyStep(
      icon: Icon(Icons.electric_bolt),
      title: "Plan de Ahorro",
      lineText: '',
    ),
  ];
}
