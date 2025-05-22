import 'package:flutter/material.dart';

class CustomCheckboxQuestion extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onChanged;

  const CustomCheckboxQuestion({
    Key? key,
    required this.questionText,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Wrap(
          children: options.map((option) {
            final isChecked = selectedValues.contains(option);
            return Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(option),
                value: isChecked,
                onChanged: (bool? value) {
                  List<String> updated = List.from(selectedValues);
                  if (value == true) {
                    updated.add(option);
                  } else {
                    updated.remove(option);
                  }
                  onChanged(updated);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
