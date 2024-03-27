import 'package:flutter/material.dart';

class EidTextField extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String errorText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction inputAction;

  EidTextField({
    @required
    this.labelText,
    @required
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputAction
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: inputAction,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16.0
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.0
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          errorStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.red
          ),
          errorMaxLines: 2,
      ),
    );
  }
}
