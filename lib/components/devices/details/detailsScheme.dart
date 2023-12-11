import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/details/chartConsumoDiario.dart';
import 'package:wattkeeperr/components/devices/details/generalInfo.dart';
import 'package:wattkeeperr/components/devices/details/historialConsumo.dart';
import 'package:wattkeeperr/components/devices/details/limits.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/thirdStep.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';
import 'package:wattkeeperr/models/MedicionGrafico.dart';
import 'package:wattkeeperr/models/medicion.dart';
import 'package:web_socket_channel/io.dart';

class DeviceDetailsScheme extends StatefulWidget {
  final String token;
  final DeviceDetails deviceDetails;
  final double acumuladoWatts;
  final double amperaje;
  final double voltaje;
  final DateTime? fechaMedicion;
  final Function() setEditable;
  final Function(String key, String value) addLimitation;
  final Function(String key, String? value) addForm;
  final Function(String key) removeForm;
  const DeviceDetailsScheme(
      {super.key,
      required this.token,
      required this.deviceDetails,
      required this.setEditable,
      required this.addForm,
      required this.removeForm,
      required this.addLimitation,
      required this.acumuladoWatts,
      required this.fechaMedicion,
      required this.amperaje,
      required this.voltaje});

  @override
  State<DeviceDetailsScheme> createState() => _DeviceDetailsSchemeState();
}

class _DeviceDetailsSchemeState extends State<DeviceDetailsScheme> {
  final controller = DeviceController();
  late final IOWebSocketChannel channel;
  bool loading = true;
  double consumo = 0.0;
  double voltaje = 0.0;
  double amperaje = 0.0;
  String tiempoTranscurrido = "";
  String ultimaMedicion = "";
  List<Medicion> mediciones = [];
  List<MedicionGrafico> medicionesGrafico = [];
  TextEditingController descripcionController = TextEditingController();
  String formattedDate(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime == null) {
      return '';
    }

    final formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";

    return formattedDate;
  }

  String calculateTimeDifference(String dateTimeString) {
    DateTime? dateTime = DateTime.tryParse(dateTimeString);

    if (dateTime == null) {
      return 'Fecha inválida';
    }

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return "Hace ${difference.inSeconds} segundos";
    } else if (difference.inMinutes < 60) {
      return "Hace ${difference.inMinutes} minutos";
    } else if (difference.inHours < 24) {
      return "Hace ${difference.inHours} horas";
    } else {
      return "Hace ${difference.inDays} días";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initChannel();
    initData();
    streamListener();

    descripcionController.text = widget.deviceDetails.descripcion;
  }

  initChannel() {
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/devices/${widget.deviceDetails.id}');
  }

  void initData() async {
    consumo = widget.acumuladoWatts;
    amperaje = widget.amperaje;
    voltaje = widget.voltaje;
    ultimaMedicion = formattedDate(widget.fechaMedicion.toString());
    tiempoTranscurrido =
        calculateTimeDifference(widget.fechaMedicion.toString());
    mediciones = await controller.getMedicionesDevice(
        widget.token, widget.deviceDetails.id);
    medicionesGrafico = await controller.getMedicionesGraficoDevice(
        widget.token, widget.deviceDetails.id);
    setState(() {
      loading = false;
    });
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
  }

  String convertDateFormat(String date) {
    DateTime dateTime = DateTime.parse(date);
    return "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}";
  }

  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      Medicion medicion =
          Medicion.fromJson(data["data"] as Map<String, dynamic>);
      
      setState(() {
        consumo = consumo + data["data"]["watts"];
        amperaje = data["data"]["amperaje"];
        voltaje = data["data"]["voltaje"];
        
        ultimaMedicion =
            formattedDate(data["data"]["fecha_medicion"]).toString();
        tiempoTranscurrido =
            calculateTimeDifference(data["data"]["fecha_medicion"]).toString();
        mediciones.add(medicion);
        String fechaMedicion =
            "${convertDateFormat(data["data"]["fecha_medicion"])} 00:00:00.000";
        for (var medicion in medicionesGrafico) {
          if (medicion.fechaDia.toString() == fechaMedicion) {
            print("coincidencia");
            medicion.consumo = medicion.consumo +
                data["data"]["watts"]; // Incrementa el valor de 'consumo'
            break; // Salir del bucle una vez que se encuentra la coincidencia
          }
        }
        medicionesGrafico = List.from(medicionesGrafico);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !loading
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      text: "ID: ",
                      style: Theme.of(context).textTheme.labelMedium,
                      children: [
                        TextSpan(
                            text: widget.deviceDetails.direccionMac,
                            style: Theme.of(context).textTheme.labelSmall)
                      ])),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextFieldCustom(
                    hintText: 'Introduce una descripción',
                    labelText: 'Descripción',
                    controller: descripcionController,
                    icon: Icons.description,
                    onChanged: (value) {
                      setState(() {
                        widget.setEditable();
                      });
                      widget.addForm("descripcion", descripcionController.text);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Limitación',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  LimitsDeviceDetails(
                    addLimitation: widget.addLimitation,
                    deviceDetails: widget.deviceDetails,
                    setEditable: widget.setEditable,
                    enabled: widget.deviceDetails.enabled,
                    addForm: widget.addForm,
                    removeForm: widget.removeForm,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Informacion General',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  GeneralInfoDeviceDetails(
                      amperaje: amperaje,
                      voltaje: voltaje,
                      acumuladoWatts: consumo,
                      ultimaMedicion: ultimaMedicion,
                      tiempoTranscurrido: tiempoTranscurrido),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Historial de Consumo',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  HistorialConsumoDispositivo(
                    mediciones: mediciones,
                    id: widget.deviceDetails.id,
                    token: widget.token,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Consumo Diario',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  ChartConsumoDiario(
                    mediciones: medicionesGrafico,
                  ),
                ],
              ),
            ),
          )
        : LoadingAnimation();
  }
}
