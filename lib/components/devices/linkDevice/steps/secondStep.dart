import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/linkDevice/steps/carouselImage.dart';
import 'package:wattkeeperr/components/forms/customTextFormField.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';

class SecondStepLinkDevice extends StatelessWidget {
  final Function() back;
  final Function() next;
  String tamagochiSelected = "";
  final String token;
  final Function(String key, String value) addForm;
  SecondStepLinkDevice(
      {super.key,
      required this.back,
      required this.next,
      required this.addForm,
      required this.token});

  void setTamagochiSelected(String value) {
    tamagochiSelected = value;
  }

  @override
  Widget build(BuildContext context) {
    final controller = DeviceController();
    final TextEditingController nombreDispositivoController =
        TextEditingController();
    final TextEditingController descripcionDispositivoController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informacion acerca del dispositivo',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextFormField(
              textInputType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Ingrese un nombre";
                }
                return null;
              },
              hintText: 'Nombre del Dispositivo',
              labelText: 'Nombre',
              controller: nombreDispositivoController,
              icon: Icons.device_unknown),
          SizedBox(
            height: 10,
          ),
          TextFieldCustom(
            hintText: 'Descripción',
            labelText: 'Descripción',
            controller: descripcionDispositivoController,
            icon: Icons.description,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Icono',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: controller.getTamagochisImages(token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CarouselImage(
                    tamagochis: snapshot.data!,
                    addForm: addForm,
                    setTamagochiSelected: setTamagochiSelected,
                  );
                } else {
                  return LoadingAnimation();
                }
              }),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: back,
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
                      if (formKey.currentState!.validate()) {
                        if (tamagochiSelected.isNotEmpty) {
                          addForm("nombre", nombreDispositivoController.text);
                          addForm("descripcion",
                              descripcionDispositivoController.text);
                          next();
                        } else {
                          SnackBars().warningMessage(context,
                              title: 'Llenar Datos',
                              message: 'Falta seleccionar un icono');
                        }
                      }
                    },
                    child: Text(
                      'Siguiente',
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
