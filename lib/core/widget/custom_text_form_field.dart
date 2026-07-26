import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    required this.title,
  });

  final TextEditingController controller;
  // call back Function.
  final String? Function(String?)? validator;
  final int? maxLines;
  final String hintText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: validator,
          controller: controller,
          maxLines: maxLines,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
