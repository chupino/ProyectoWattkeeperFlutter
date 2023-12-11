import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/details/home/consumoGrupoCard.dart';
import 'package:wattkeeperr/components/groups/details/home/historialConsumoGrupo.dart';
import 'package:wattkeeperr/components/groups/details/home/resumenCard.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';
import 'package:wattkeeperr/models/GroupMedicion.dart';
import 'package:wattkeeperr/models/medicion.dart';
import 'package:web_socket_channel/io.dart';

class HomeGroupScheme extends StatefulWidget {
  final String token;
  final Future Function() onRefresh;
  final GroupDetails groupDetails;
  const HomeGroupScheme(
      {super.key,
      required this.token,
      required this.groupDetails,
      required this.onRefresh});

  @override
  State<HomeGroupScheme> createState() => _HomeGroupSchemeState();
}

class _HomeGroupSchemeState extends State<HomeGroupScheme> {
  final controller = GroupController();
  List<GroupMedicion> mediciones = [];
  double consumoActual = 0.0;
  double consumoTotal = 0.0;
  double voltajeTotal = 0.0;
  double amperajeTotal = 0.0;
  String fechaMedicion = "";
  bool loading = true;
  late final IOWebSocketChannel channel;

  initChannel() {
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/grupos/${widget.groupDetails.id}');
  }

  void initData() async {
    mediciones =
        await controller.getGroupMedicion(widget.token, widget.groupDetails.id);
    if (mediciones.isNotEmpty) {
      consumoTotal = mediciones
          .expand((item) => item.mediciones)
          .where((medicion) => medicion.watts != null)
          .map((medicion) => medicion.watts!)
          .fold(0.0, (a, b) => a + b);
    } else {
      consumoTotal = 0.0;
    }

    consumoActual = widget.groupDetails.acumuladoWattsTotal ?? 0;

     if (mediciones.isNotEmpty) {
  List<DateTime?> fechas = mediciones
      .expand((item) => item.mediciones)
      .map((medicion) => medicion.fechaMedicion)
      .where((fecha) => fecha != null)
      .cast<DateTime>() // Necesario para que Dart entienda que no hay elementos nulos
      .toList();

  if (fechas.isNotEmpty) {
    fechaMedicion = fechas.reduce((a, b) => a!.isAfter(b!) ? a : b)!.toIso8601String();
  } else {
    fechaMedicion = "";
  }
} else {
  fechaMedicion = "";
}

    for (var item in mediciones) {
      List<dynamic> medicionesList = item.mediciones;

      if (medicionesList.isNotEmpty) {
        medicionesList
            .sort((a, b) => b.fechaMedicion.compareTo(a.fechaMedicion));
        voltajeTotal += medicionesList[0].voltaje ?? 0;
      }
    }
    for (var item in mediciones) {
      List<dynamic> medicionesList = item.mediciones;

      if (medicionesList.isNotEmpty) {
        medicionesList
            .sort((a, b) => b.fechaMedicion.compareTo(a.fechaMedicion));
        amperajeTotal +=
            medicionesList[0].amperaje ?? 0.0; // Usa 0.0 si amperaje es nulo
      }
    } 
    setState(() {
      loading = false;
    });
    print(mediciones);
  }

  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      Medicion medicion =
          Medicion.fromJson(data["data"] as Map<String, dynamic>);
      for (var i = 0; i < mediciones.length; i++) {
        if (mediciones[i].device.direccionMac == medicion.direccionMac) {
          setState(() {
            mediciones[i].mediciones.insert(0, medicion);
            consumoActual = consumoActual + medicion.watts;
            consumoTotal = consumoTotal + medicion.watts;
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initChannel();
    initData();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    return !loading
        ? RefreshIndicator(
            onRefresh: widget.onRefresh,
            child: ListView(
              children: [
                Text.rich(TextSpan(
                    text: "Bienvenido de nuevo al grupo ",
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                          text: widget.groupDetails.nombre,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.amber))
                    ])),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Consumo",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ConsumoGrupoCard(
                  amperaje: amperajeTotal,
                  voltaje: voltajeTotal,
                  wattsAcumulado: consumoActual,
                  fecha: fechaMedicion,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Resumen del Grupo",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                ResumenCard(groupDetails: widget.groupDetails),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Historial de Consumo",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text.rich(TextSpan(
                    text: "Total Watts: ",
                    style: Theme.of(context).textTheme.labelMedium,
                    children: [
                      TextSpan(
                          text: "${consumoTotal}W",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.amber))
                    ])),
                SizedBox(
                  height: 10,
                ),
                HistorialConsumoGrupo(
                  mediciones: mediciones,
                  devices: widget.groupDetails.dispositivos,
                )
              ],
            ),
          )
        : LoadingAnimation();
  }
}
