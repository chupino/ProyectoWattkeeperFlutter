import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';
import 'package:wattkeeperr/components/forms/customTextFormField.dart';
import 'package:wattkeeperr/components/navBar/navBar.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/pages/deviceDetailsPage.dart';
import 'package:web_socket_channel/io.dart';

class DeviceCard extends StatefulWidget {
  final Device device;
  final String token;
  final Function()? reload;

  const DeviceCard(
      {required this.token, this.reload, super.key, required this.device});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  final controller = DeviceController();
  late final IOWebSocketChannel channel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/devices/${widget.device.id}');
    streamListener();
    initConsumo();
  }

  double consumo = 0.0;
  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      setState(() {
        consumo = consumo + data["data"]["watts"];
      });
    });
  }

  void initConsumo() async {
    consumo = widget.device.acumuladoWattsTotal;
  }

  void mostrarCambiarNombre(BuildContext context) {
    final cambiarNombreController =
        TextEditingController(text: widget.device.nombre);
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Cambiar Nombre'),
          content: Form(
            key: formKey,
            child: CustomTextFormField(
              textInputType: TextInputType.name,
              controller: cambiarNombreController,
              hintText: 'Nombre',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingrese un nombre";
                }
                return null;
              },
              icon: Icons.devices,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                ; // Cierra el cuadro de diálogo
              },
              child: Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.changeNameDevice(widget.token, widget.device.id,
                      cambiarNombreController.text, widget.device.direccionMac);
                  widget.reload != null ? widget.reload!() : null;
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              child: Text('Aplicar'),
            ),
          ],
        );
      },
    );
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
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    mostrarCambiarNombre(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cambiar Nombre',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    controller
                        .unlinkDevice(widget.token, widget.device.id)
                        .then((value) {
                      if (value == true) {
                        SnackBars().successMessage(context,
                            title: 'Desvinculado',
                            message:
                                'El dispositivo se desvinculó correctamente');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NavBarWattKeeper(initialIndex: 2)),
                            (route) => false);
                      } else {
                        SnackBars().failureMessage(context,
                            title: 'Error', message: 'Algo ocurrió mal');
                      }
                    }).catchError((e) {
                      SnackBars().failureMessage(context,
                          title: 'Error', message: 'Algo ocurrió mal');
                      return Future.error(
                          e); // Agrega esta línea para devolver un Future.error con el mismo error
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Desvincular',
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
    return GestureDetector(
      onLongPress: () {
        openBottomSheet(context);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DeviceDetailsPage(device: widget.device, token: widget.token,),
          ),
        );
      },
      child: Stack(
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
                        child: Image.network(widget.device.getTamagochiDynamicImage()))
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
                "${consumo / 1000} kW",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
