import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/buttons/counterCustom.dart';
import 'package:wattkeeperr/components/navBar/navBar.dart';
import 'package:wattkeeperr/components/settings/switchCustom.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';

class ThirdStepLinkDevice extends StatefulWidget {
  final Map<String, dynamic> form;
  final Function() back;
  final String token;
  final Function(String key, String value) addForm;
  final Function(String key) removeItemForm;
  const ThirdStepLinkDevice(
      {super.key,
      required this.form,
      required this.addForm,
      required this.removeItemForm,
      required this.token,
      required this.back});

  @override
  State<ThirdStepLinkDevice> createState() => _ThirdStepLinkDeviceState();
}

enum TipoMedicion { dias, semanas, meses }

class _ThirdStepLinkDeviceState extends State<ThirdStepLinkDevice> {
  bool isActive = false;
  double limiteConsumo = 1000;
  int tiempoMedicion = 1;
  String tipoMedicionString = TipoMedicion.dias.name;

  TipoMedicion? tipoDato;
  void incrementarTiempoMedicion() {
    if (tiempoMedicion < 24) {
      setState(() {
        tiempoMedicion++;
      });
    }
  }

  void decrecerTiempoMedicion() {
    if (tiempoMedicion > 1) {
      setState(() {
        tiempoMedicion--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = DeviceController();
    return Column(
      children: [
        Text(
          'Establecer Plan de Ahorros',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Habilitar',
                  ),
                  SwitchCustom(
                      value: isActive,
                      onToggle: (value) {
                        setState(() {
                          isActive = value;
                        });
                      })
                ],
              ),
              isActive
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Limite Consumo (Watts)',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Slider(
                                value: limiteConsumo,
                                min: 0,
                                max: 1200,
                                onChanged: (value) {
                                  setState(() {
                                    limiteConsumo = value;
                                  });
                                }),
                            Text(
                              "${limiteConsumo.toInt()}W",
                            )
                          ],
                        ),
                        /* SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Tiempo de Medicion',
                              ),
                            ),
                            CounterCustom(
                              counter: tiempoMedicion,
                              incrementar: incrementarTiempoMedicion,
                              decrecer: decrecerTiempoMedicion,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Tipo de Medición',
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
                            },
                            dropdownMenuEntries: TipoMedicion.values
                                .map((item) => DropdownMenuEntry(
                                    value: item.name, label: item.name))
                                .toList()), */
                      ],
                    )
                  : Lottie.asset('assets/animations/saveEnergy.json',
                      height: 250)
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: widget.back,
                  child: Text(
                    'Atras',
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                if (isActive) {
                  widget.addForm("limite_consumo", limiteConsumo.toString());
                  /* widget.addForm("tiempo_medicion", tiempoMedicion.toString());
                  widget.addForm(
                      "tipo_medicion", tipoMedicionString.toString()); */
                } else {
                  widget.removeItemForm("limite_consumo");
                  /* widget.removeItemForm("tiempo_medicion");
                  widget.removeItemForm("tipo_medicion"); */
                }
                print(widget.form);
                controller.linkDevice(widget.token, widget.form).then((value) {
                  if (value == true) {
                    final snackbar = SnackBar(
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          contentType: ContentType.success,
                          title: "Dispositivo Vinculado",
                          message:
                              "Se dispositivo se ha vinculado correctamente",
                        ));
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackbar);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NavBarWattKeeper(initialIndex: 2)),
                        (route) => false);
                  } else {}
                }).catchError((error) {
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
              child: Text('Terminar'),
            )),
          ],
        )
      ],
    );
  }
}
