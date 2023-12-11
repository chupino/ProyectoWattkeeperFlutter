import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/counterCustom.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/thirdStep.dart';
import 'package:wattkeeperr/components/groups/details/devices/limitacionSwitch.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';

class LimitsDeviceDetails extends StatefulWidget {
  DeviceDetails deviceDetails;
  bool enabled;
  final Function() setEditable;
  final Function(String key, String value) addLimitation;
  final Function(String key, String? value) addForm;
  final Function(String key) removeForm;
  LimitsDeviceDetails({
    super.key,
    required this.deviceDetails,
    required this.setEditable,
    required this.enabled,
    required this.addForm,
    required this.removeForm,
    required this.addLimitation,
  });

  @override
  State<LimitsDeviceDetails> createState() => _LimitsDeviceDetailsState();
}

class _LimitsDeviceDetailsState extends State<LimitsDeviceDetails> {
  late DeviceDetails deviceDetails;
  double limiteConsumo = 1000;
/*   int tiempoMedicion = 1;
  String tipoMedicionString = ""; */
  late bool localEnabled;

  @override
  void initState() {
    super.initState();
    deviceDetails = widget.deviceDetails;
    deviceDetails.limiteConsumo != null
        ? limiteConsumo = deviceDetails.limiteConsumo!
        : limiteConsumo = 1000;
/*     deviceDetails.tiempoMedicion != null
        ? tiempoMedicion = deviceDetails.tiempoMedicion!
        : tiempoMedicion = 1;
    deviceDetails.tipoMedicion != null
        ? tipoMedicionString = deviceDetails.tipoMedicion!
        : tipoMedicionString = TipoMedicion.dias.name; */
    localEnabled = widget.enabled;
/*     widget.addLimitation("limite_consumo", limiteConsumo.toString());
    widget.addLimitation("tiempo_medicion", tiempoMedicion.toString());
    widget.addLimitation("tipo_medicion", tipoMedicionString); */
    print(localEnabled);
    widget.addLimitation("enabled", localEnabled.toString());
    /* print(tipoMedicionString); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        LimitationSwitch(
            onToggle: (value) {
              if (value == false) {
                widget.removeForm("limite_consumo");
                /* widget.removeForm("tiempo_medicion");
                widget.removeForm("tipo_medicion"); */
                widget.setEditable();
              } else {
                widget.setEditable();
                widget.addLimitation("limite_consumo", "1000");
                /* widget.addLimitation("tiempo_medicion", "1");
                widget.addLimitation("tipo_medicion", "dias"); */
              }
              setState(() {
                localEnabled = value;
              });
              widget.addLimitation("enabled", localEnabled.toString());
            },
            enabled: localEnabled),
        const SizedBox(
          height: 10,
        ),
        localEnabled
            ? Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Limite Consumo',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoSlider(
                              value: limiteConsumo,
                              min: 0,
                              max: 513715,
                              onChanged: (value) {
                                setState(() {
                                  limiteConsumo = value;
                                });
                                widget.setEditable();
                                widget.addLimitation(
                                    "limite_consumo", limiteConsumo.toString());
                              }),
                          Text(
                            "${limiteConsumo.toInt() / 1000}kW",
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiempo Medición',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ), //subir bajar
                      CounterCustom(
                          counter: tiempoMedicion,
                          incrementar: () {
                            setState(() {
                              tiempoMedicion = tiempoMedicion + 1;
                            });
                            widget.addLimitation(
                                "tiempo_medicion", tiempoMedicion.toString());
                            widget.setEditable();
                          },
                          decrecer: () {
                            setState(() {
                              tiempoMedicion = tiempoMedicion - 1;
                            });
                            widget.addLimitation(
                                "tiempo_medicion", tiempoMedicion.toString());
                            widget.setEditable();
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipo Medición',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownMenu(
                          width: MediaQuery.of(context).size.width - 50,
                          initialSelection: tipoMedicionString,
                          onSelected: (value) {
                            setState(() {
                              tipoMedicionString = value!;
                            });
                            widget.addLimitation(
                                "tipo_medicion", tipoMedicionString);
                            widget.setEditable();
                          },
                          dropdownMenuEntries: TipoMedicion.values
                              .map((item) => DropdownMenuEntry(
                                  value: item.name, label: item.name))
                              .toList()),
                    ],
                  ), */
                ],
              )
            : Container()
      ]),
    );
  }
}
