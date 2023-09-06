import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  
  final String text;
  final void Function()? onTap;
  const ButtonWidget({required this.onTap,required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        color: Colors.cyan,
        height: 80,
        width: 200,
        child: Text(text),
      ),
    );
  }
}
