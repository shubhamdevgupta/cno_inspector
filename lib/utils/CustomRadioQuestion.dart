import 'package:flutter/material.dart';

class CustomRadioQuestion extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final String? selectedValue;
  final Function(String?) onChanged;

  const CustomRadioQuestion({
    Key? key,
    required this.questionText,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure there are at least 2 options
    final safeOptions = options.length >= 2 ? options : ['Yes', 'No'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionText,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Wrap(
          alignment: WrapAlignment.start,
          children: safeOptions.map((option) {
            return Container(
              width: MediaQuery.of(context).size.width / 2 - 20, // 2 in a row
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: onChanged,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
