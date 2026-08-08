import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  // call back Function.
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: Color(0xFF15B86C),
      onChanged: onChanged,
      checkColor: Color(0xFFFFFCFC),
    );
  }
}
