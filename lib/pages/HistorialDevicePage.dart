import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/historial/historialScheme.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/medicion.dart';
import 'package:web_socket_channel/io.dart';

class HistorialDevicePage extends StatefulWidget {
  final String token;
  final int idDevice;
  const HistorialDevicePage(
      {super.key, required this.token, required this.idDevice});

  @override
  State<HistorialDevicePage> createState() => _HistorialDevicePageState();
}

class _HistorialDevicePageState extends State<HistorialDevicePage> {
  bool loading = true;
  List<Medicion> mediciones = [];
  final controller = DeviceController();
  late final IOWebSocketChannel channel;

  void initData() async {
    mediciones =
        await controller.getMedicionesDevice(widget.token, widget.idDevice);
    mediciones.sort((a, b) => b.fechaMedicion!.compareTo(a.fechaMedicion!));
    setState(() {
      loading = false;
    });
  }

  initChannel() {
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/devices/${widget.idDevice}');
  }

  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      Medicion medicion =
          Medicion.fromJson(data["data"] as Map<String, dynamic>);
      print(medicion);
      print(data);
      setState(() {
        mediciones.add(medicion);
        mediciones.sort((a, b) => b.fechaMedicion!.compareTo(a.fechaMedicion!));
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Consumo"),
      ),
      body: !loading
          ? HistorialScheme(mediciones: mediciones)
          : LoadingAnimation(),
    );
  }
}
