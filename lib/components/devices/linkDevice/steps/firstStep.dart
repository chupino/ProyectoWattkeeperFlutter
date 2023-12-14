import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/devices/linkDevice/deviceScanned.dart';
import 'package:wattkeeperr/pages/scannerQR.dart';

class FirstStepLinkDevice extends StatefulWidget {
  final Function() next;
  final Function(String key, String value) addForm;
  const FirstStepLinkDevice(
      {super.key, required this.next, required this.addForm});

  @override
  State<FirstStepLinkDevice> createState() => _FirstStepLinkDeviceState();
}

class _FirstStepLinkDeviceState extends State<FirstStepLinkDevice> {
  bool isDone = true;
  //wattkeeper oficial mac: 94:E6:86:3C:C2:AC-wattkeeper
  String resultado = "94:E6:86:3C:C1:AC-wattkeeper";
  @override
  Widget build(BuildContext context) {
    return !isDone
        ? Column(
            children: [
              Text(
                'Procederemos a escanear el codigo QR de tu dispositivo',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Lottie.asset('assets/animations/scan.json',
                              height: 250, fit: BoxFit.cover),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                resultado = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScanQR()));
                                print("++++++++++++++++++++++$resultado");
                                setState(() {
                                  isDone = true;
                                });
                              },
                              child: const Text('Escanear Ahora'))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dispositivo Detectado: ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),
              DeviceScanned(direccionMac: resultado),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            widget.addForm("direccion_mac", resultado);
                            widget.next();
                          },
                          child: const Text(
                            'Siguiente',
                          ))),
                ],
              )
            ],
          );
  }
}
