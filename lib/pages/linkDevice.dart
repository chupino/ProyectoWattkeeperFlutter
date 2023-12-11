import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/linkDevice/linkDeviceHeader.dart';
import 'package:wattkeeperr/components/devices/linkDevice/stepperLinkDevice.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/firstStep.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/secondStep.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/thirdStep.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';

class LinkDevicePage extends StatefulWidget {
  final String token;
  const LinkDevicePage({super.key, required this.token});

  @override
  State<LinkDevicePage> createState() => _LinkDevicePageState();
}

class _LinkDevicePageState extends State<LinkDevicePage> {
  int stepActive = 0;
  Map<String, dynamic> formBody = {};
  void nextStep() {
    setState(() {
      stepActive++;
    });
  }

  void addForm(String clave, dynamic valor) {
    formBody[clave] = valor;
    print(formBody);
  }

  void removeItemForm(String clave) {
    formBody.remove(clave);
  }

  void backStep() {
    setState(() {
      stepActive--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreDispositivoController =
        TextEditingController();
    final TextEditingController direccionMacController =
        TextEditingController();
    final controller = DeviceController();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [LinkDeviceHeader()];
        },
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StepperLinkDevice(activeStep: stepActive),
              Expanded(
                child: SingleChildScrollView(
                  child: stepActive == 0
                      ? FirstStepLinkDevice(
                          next: nextStep,
                          addForm: addForm,
                        )
                      : stepActive == 1
                          ? SecondStepLinkDevice(
                              token: widget.token,
                              back: backStep,
                              next: nextStep,
                              addForm: addForm,
                            )
                          : ThirdStepLinkDevice(
                            back: backStep,
                              addForm: addForm,
                              removeItemForm: removeItemForm,
                              token: widget.token,
                              form: formBody,
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
