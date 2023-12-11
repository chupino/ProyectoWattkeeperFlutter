import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final bool? readOnly;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  const TextFieldCustom(
      {super.key,
      required this.hintText,
      this.labelText,
      this.icon,
      this.controller,
      this.onChanged, 
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      readOnly: readOnly ?? false,
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
