import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miventahome/ui/app_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomInputText extends StatelessWidget {
  final String ctrlName;
  final String label;
  final TextInputFormatter type;
  final Color borderColor;
  final Color labelColor;

  const CustomInputText({
    Key? key,
    required this.ctrlName,
    required this.label,
    required this.type,
    this.borderColor = kPrimaryColor,
    this.labelColor = kSecondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReactiveTextField(
        formControlName: ctrlName,
        validationMessages: {
          ValidationMessage.required: (error) =>
              'Ingrese su número de telefono',
          ValidationMessage.maxLength: (error) =>
              'Ingrese un número de telefono válido',
          ValidationMessage.minLength: (error) =>
              'Ingrese un número de telefono válido',
        },
        maxLength: 8,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(7.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          labelText: label,
          labelStyle: TextStyle(fontSize: 15, color: labelColor),
        ),
      ),
    );
  }
}
