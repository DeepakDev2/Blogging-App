import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hint,
      required this.controller,
      this.isObsecure = false});

  final String hint;
  final TextEditingController controller;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "I$hint is missing";
        }
        return null;
      },
    );
  }
}
