import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final String Function(String?)? validator;
  const EmailTextFormField({
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
      keyboardType: textInputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese un correo electrónico';
        }

        final RegExp emailRegExp =
            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

        if (!emailRegExp.hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }

        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
