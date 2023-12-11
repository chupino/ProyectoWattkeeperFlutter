import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String? value) validator;
  const PasswordField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    required this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.password),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
         // Ajuste el relleno del contenido
         // Oculta el borde predeterminado del TextField
      ),
      obscureText: isVisible,
    );
  }
}
