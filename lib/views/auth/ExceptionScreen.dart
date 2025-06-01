import 'package:flutter/material.dart';

class ExceptionScreen extends StatelessWidget {
  final String errorMessage;

  const ExceptionScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            "An Error Occurred",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}
