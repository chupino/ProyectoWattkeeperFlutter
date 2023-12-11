
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/thirdStep.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/groups/details/devices/limitacionSwitch.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';

class DeviceDetailsNoEditScheme extends StatefulWidget {
  final String token;
  final DeviceDetails deviceDetails;
  const DeviceDetailsNoEditScheme({
    super.key,
    required this.token,
    required this.deviceDetails,
  });

  @override
  State<DeviceDetailsNoEditScheme> createState() =>
      _DeviceDetailsNoEditSchemeState();
}

class _DeviceDetailsNoEditSchemeState extends State<DeviceDetailsNoEditScheme> {
  final controller = DeviceController();
  

  String tipoMedicionString = TipoMedicion.dias.name;
  TextEditingController descripcionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descripcionController.text = widget.deviceDetails.descripcion;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text.rich(TextSpan(
                text: "ID: ",
                children: [
                  TextSpan(
                      text: widget.deviceDetails.direccionMac,)
                ])),
            const SizedBox(
              height: 10,
            ),
            TextFieldCustom(
              hintText: 'Introduce una descripción',
              labelText: 'Descripción',
              controller: descripcionController,
              icon: Icons.description,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  LimitationSwitch(
                      onToggle: (value) {},
                      enabled: widget.deviceDetails.enabled),
                  const SizedBox(
                    height: 10,
                  ),
                  widget.deviceDetails.enabled
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Limite Consumo',),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Slider(
                                    value: widget.deviceDetails.limiteConsumo ??
                                        1000,
                                    min: 1000,
                                    max: 10000,
                                    divisions: 9,
                                    onChanged: (value) {}),
                                Text(
                                  "${widget.deviceDetails.limiteConsumo}W",
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            
                          ],
                        )
                      : Container()
                ])),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Image.network(
                    widget.deviceDetails.getTamagochiImage(),
                    height: 200,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(TextSpan(
                      text: 'Recompensa 1: ',
                      children: [
                        TextSpan(
                            text: 'Doritos',)
                      ])),
                  Text.rich(TextSpan(
                      text: 'Recompensa 2: ',
                      children: [
                        TextSpan(
                            text: 'Doritos',)
                      ])),
                  Text.rich(TextSpan(
                      text: 'Recompensa 3: ',
                      children: [
                        TextSpan(
                            text: 'Doritos',)
                      ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
