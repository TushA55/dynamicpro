import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.labelText,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.digitsOnly = false,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.onChanged,
  });

  final String? labelText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool digitsOnly;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
      inputFormatters: [
        ...inputFormatters ?? [],
        if (digitsOnly) FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: digitsOnly ? TextInputType.number : TextInputType.text,
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
    );
  }
}
