import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomMultiSelectChipQuestion extends StatefulWidget {
  final String question;
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onSelectionChanged;

  const CustomMultiSelectChipQuestion({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _CustomMultiSelectChipQuestionState createState() =>
      _CustomMultiSelectChipQuestionState();
}

class _CustomMultiSelectChipQuestionState
    extends State<CustomMultiSelectChipQuestion> {
  late List<String> selectedChoices;

  @override
  void initState() {
    super.initState();
    selectedChoices = widget.selectedValues;
  }

  _onChoiceSelected(String choice) {
    setState(() {
      if (selectedChoices.contains(choice)) {
        selectedChoices.remove(choice);
      } else {
        selectedChoices.add(choice);
      }
      widget.onSelectionChanged(selectedChoices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8.0,
            children: widget.options.map((option) {
              final isSelected = selectedChoices.contains(option);
              return ChoiceChip(
                label: Text(option),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                selectedColor: Colors.deepOrange,
                backgroundColor: Colors.grey[200],
                selected: isSelected,
                onSelected: (_) => _onChoiceSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
