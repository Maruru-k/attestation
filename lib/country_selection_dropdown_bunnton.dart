import 'dart:developer';

import 'package:flutter/material.dart';

class CountrySelectionDropdownButton extends StatelessWidget {
  final List<String> _list;
  final String _dropdownValue;
  final Function(String?) _onTap;

  const CountrySelectionDropdownButton({
    super.key,
    required List<String> list,
    required String dropdownValue,
    required Function(String?) onTap,
  })  : _list = list,
        _onTap = onTap,
        _dropdownValue = dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Страна прибытия",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
            ),
            onChanged: _onTap,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            items: _list.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
