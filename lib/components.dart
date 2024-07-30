import 'package:farmers_guide/utils.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;
  const PrimaryButton(
      {super.key, required this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: Utils.primaryButtonStyle,
        child: Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
