import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/forms/customTextFormField.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';

class DevicesDetailsHeaderMini extends StatelessWidget {
  final DeviceDetails deviceDetails;
  final String token;
  final Function()? reload;
  final controller = DeviceController();
  DevicesDetailsHeaderMini({
    super.key,
    required this.deviceDetails,
    required this.token,
    this.reload,
  });
  void mostrarCambiarNombre(BuildContext context) {
    final cambiarNombreController =
        TextEditingController(text: deviceDetails.nombre);
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
                  controller.changeNameDevice(token, deviceDetails.id,
                      cambiarNombreController.text, deviceDetails.direccionMac);
                  reload != null ? reload!() : null;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C2434),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                deviceDetails.nombre,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            reload != null
                ? IconButton(
                    onPressed: () {
                      mostrarCambiarNombre(context);
                    },
                    icon: Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        )),
      ),
    );
  }
}
