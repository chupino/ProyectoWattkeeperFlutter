import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final IconData? icon;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  const DatePickerTextField(
      {super.key,
      required this.hintText,
      this.labelText,
      this.icon,
      required this.textInputType,
      this.controller,
      this.validator,
      this.readOnly});

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      keyboardType: widget.textInputType,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Introduzca un valor';
            }
            return null;
          },
      controller: widget.controller,
      onTap: widget.readOnly != null && widget.readOnly == false
          ? () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                setState(() {
                  widget.controller!.text =
                      DateFormat('dd MMMM y', 'es').format(pickedDate);
                });
              }
            }
          : () {
              // Manejar el caso cuando widget.readOnly es null o false
            },
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        labelText: widget.labelText,
        hintText: widget.hintText,

        // Ajuste el relleno del contenido
        // Oculta el borde predeterminado del TextField
      ),
    );
  }
}
