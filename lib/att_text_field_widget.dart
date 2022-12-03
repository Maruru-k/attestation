import 'package:flutter/material.dart';

class AttTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;

  const AttTextFieldWidget({
    super.key,
    required this.label,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        controller: textEditingController,
        decoration: InputDecoration(
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            )),
      ),
    );
  }
}
