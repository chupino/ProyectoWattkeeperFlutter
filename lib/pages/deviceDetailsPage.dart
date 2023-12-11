import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/details/detailsScheme.dart';
import 'package:wattkeeperr/components/devices/details/header/header.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/Device.dart';

class DeviceDetailsPage extends StatefulWidget {
  final Device device;
  final String token;
  const DeviceDetailsPage(
      {super.key, required this.device, required this.token});

  @override
  State<DeviceDetailsPage> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetailsPage> {
  final controller = DeviceController();
  Map<String, dynamic> deviceForm = {};
  int dummy = 0;
  bool wasEditable = false;
  void setSave() {
    setState(() {
      wasEditable = true;
      print(wasEditable);
    });
  }

  void addLimitation(String key, String valor) {
    if (deviceForm.containsKey("limitacion")) {
      deviceForm["limitacion"][key] = valor;
    } else {
      deviceForm["limitacion"] = {key: valor};
    }
  }

  void eliminarLimitacion() {
    if (deviceForm.containsKey("limitacion")) {
      deviceForm.remove("limitacion");
    }
  }

  void addFormDevice(String key, String? value) {
    deviceForm[key] = value;
    print(deviceForm);
  }

  void removeFormDevice(String key) {
    deviceForm.remove(key);
    print(deviceForm);
  }

  void reload() {
    setState(() {
      dummy++;
    });
  }

  @override
  void initState() {
    super.initState();
    deviceForm = {
      "nombre": widget.device.nombre,
      "direccion_mac": widget.device.direccionMac,
    };
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: wasEditable
          ? FloatingActionButton(
              onPressed: () {
                print(deviceForm);
                controller
                    .editDevice(
                  id: widget.device.id,
                  token: widget.token,
                  direccionMac: deviceForm["direccion_mac"],
                  nombre: deviceForm["nombre"],
                  descripcion: deviceForm["descripcion"],
                  enabled: deviceForm["limitacion"]["enabled"],
                  limiteConsumo: deviceForm["limitacion"]["limite_consumo"],
                )
                    .then((value) {
                  if (value == true) {
                    final snackbar = SnackBar(
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          contentType: ContentType.success,
                          title: "Dispositivo Actualizado",
                          message:
                              "Se dispositivo se ha actualizado correctamente",
                        ));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackbar);
                  } else {
                    final snackbar = SnackBar(
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          contentType: ContentType.failure,
                          title: "Ocurrio algo mal",
                          message: "Algo salio mal",
                        ));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackbar);
                  }
                }).catchError((e) {
                  final snackbar = SnackBar(
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        contentType: ContentType.failure,
                        title: "Ocurrio algo mal",
                        message: "Algo salio mal",
                      ));
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackbar);
                });
              },
              child: Icon(
                Icons.save,
                color: Colors.white,
                size: 40,
              ),
              backgroundColor: Color.fromARGB(255, 13, 2, 54),
            )
          : null,
      body: FutureBuilder(
          future: controller.getDeviceDetailsUser(
              widget.token, widget.device.id, dummy),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: DevicesHeader(
                          deviceDetails: snapshot.data!,
                          size: size,
                          token: widget.token,
                          reload: reload)),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    DeviceDetailsScheme(
                      amperaje: widget.device.amperaje,
                      voltaje: widget.device.voltaje,
                      acumuladoWatts: widget.device.acumuladoWatts,
                      fechaMedicion: widget.device.fechaMedicion,
                      addLimitation: addLimitation,
                      addForm: addFormDevice,
                      removeForm: removeFormDevice,
                      setEditable: setSave,
                      token: widget.token,
                      deviceDetails: snapshot.data!,
                    )
                  ]))
                ],
              );
            } else {
              return LoadingAnimation();
            }
          }),
    );
  }
}
