import 'package:flutter/material.dart';

class CheckboxSelectionWidget extends StatelessWidget {
  final Map<String, bool> checkSelectionItem;
  late final List<String> keys;
  final Function(bool? value, int index) onTap;

  CheckboxSelectionWidget({
    super.key,
    required this.onTap,
    required this.checkSelectionItem,
  }) : keys = checkSelectionItem.keys.toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          keys.length,
          (index) => Row(
                children: [
                  Checkbox(
                    value: checkSelectionItem[keys[index]],
                    onChanged: (value){
                      onTap(value, index);
                    },
                  ),
                  Text(
                    keys[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )),
    );
  }
}
