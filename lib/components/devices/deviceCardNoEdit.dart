import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';
import 'package:wattkeeperr/components/forms/customTextFormField.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/pages/deviceDetailsPage.dart';
import 'package:web_socket_channel/io.dart';

class DeviceCardNoEdit extends StatefulWidget {
  final String token;
  final Device device;
  const DeviceCardNoEdit({required this.token, required this.device});

  @override
  State<DeviceCardNoEdit> createState() => _DeviceCardNoEditState();
}

class _DeviceCardNoEditState extends State<DeviceCardNoEdit> {
  final controller = DeviceController();
  late final IOWebSocketChannel channel;
  double consumo = 0.0;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/devices/${widget.device.id}');
    initData();
    streamListener();
  }

  initData() {
    consumo = widget.device.acumuladoWattsTotal / 1000;
  }

  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      print(data);
      if (mounted) {
        setState(() {
          consumo = consumo + data["data"]["watts"];
        });
      }
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isDismissible: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ID: ${widget.device.direccionMac}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Acciones',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeviceDetailsPage(
                                device: widget.device, token: widget.token)));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ver Detalles',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity, // Ajustar el ancho al tamaño deseado
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.device.nombre,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Flexible(
                      child: Image.network(
                          widget.device.getTamagochiDynamicImage()))
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.red, // Puedes ajustar el color según tu diseño
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              "${consumo}kW",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
