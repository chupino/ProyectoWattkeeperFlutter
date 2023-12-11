import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.icon,
    this.controller,
    required this.textInputType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Introduzca un valor';
            }
            return null;
          },
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        hintText: hintText,
        // Ajuste el relleno del contenido
        // Oculta el borde predeterminado del TextField
      ),
    );
  }
}
