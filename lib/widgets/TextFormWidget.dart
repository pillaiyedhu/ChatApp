import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String? texthint;
  final TextEditingController controller;
  final bool obsure;
  const TextFormWidget(
      {required this.controller,
      required this.texthint,
      required this.obsure,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "$texthint";
        }
        return null;
      },
      controller: controller,
      obscureText: obsure,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        hintText: texthint,
      ),
    );
  }
}
