import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final double fontSize;
  final Color labelColor;
  final Color hintColor;
  final Color borderColor;
  final alignment;
  final bool obscureText;
  final obscuringCharacter;

  CustomTextFormField({
    required this.onSaved,
    required this.validator,
    this.hintText = "",
    this.labelText = "",
    this.fontSize = 20.0,
    this.labelColor = Colors.grey,
    this.hintColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.alignment = Alignment.topLeft,
    this.obscureText = false,
    this.obscuringCharacter: "●",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilderTextField(
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: labelColor),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ), name: 'email',
      ),
    );
  }
}