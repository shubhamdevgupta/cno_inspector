import 'package:flutter/material.dart';

class Customradiobttn extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String?> onChanged;
  final Axis orientation;

  const Customradiobttn({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.orientation = Axis.horizontal,
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
        orientation == Axis.horizontal
            ? Wrap(
                spacing: 20,
                runSpacing: 8,
                children: options.map((option) {
                  return IntrinsicHeight(
                    // <-- Wrap Row in IntrinsicHeight
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // <-- Align center
                      children: [
                        Radio<String>(
                          value: option,
                          groupValue: selectedOption,
                          onChanged: onChanged,
                          activeColor: Colors.deepOrangeAccent,
                        ),
                        Flexible(
                          child: Text(
                            option,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: IntrinsicHeight(
                      // <-- Wrap Row in IntrinsicHeight
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // <-- Align center
                        children: [
                          Radio<String>(
                            value: option,
                            groupValue: selectedOption,
                            onChanged: onChanged,
                            activeColor: Colors.deepOrangeAccent,
                          ),
                          Expanded(
                            child: Text(
                              option,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
        const SizedBox(height: 10),
      ],
    );
  }
}
