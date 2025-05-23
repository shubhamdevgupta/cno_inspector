import 'package:flutter/material.dart';

class Customradiobttn extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;

  const Customradiobttn({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 20,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: onChanged,
                  activeColor: Colors.deepOrangeAccent,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
