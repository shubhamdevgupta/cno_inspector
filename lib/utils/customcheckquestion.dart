import 'package:flutter/material.dart';

class CustomCheckBoxQuestion extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;

  const CustomCheckBoxQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8.0,
            children: options.map((option) {
              return ChoiceChip(
                label: Text(option),
                labelStyle: TextStyle(
                  color: selectedValue == option ? Colors.white : Colors.black,
                ),
                selectedColor: Colors.deepOrange,
                backgroundColor: Colors.grey[200],
                selected: selectedValue == option,
                onSelected: (_) => onChanged(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
