import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String baselineStatus; // e.g. "Total Schemes \n$totalSchemes"
  final VoidCallback onStartPressed;
  final Color primaryColor;
  final Color accentColor;
  final String? imagePath; // Optional image path (assets or network)

  const DashboardCard({
    Key? key,
    required this.title,
    required this.baselineStatus,
    required this.onStartPressed,
    this.primaryColor = Colors.blue,
    this.accentColor = const Color(0xFFE3F2FD),
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusParts = baselineStatus.split('\n');
    final statusTitle = statusParts.first;
    final statusValue = statusParts.length > 1 ? statusParts.last : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: accentColor.withOpacity(0.9),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Status box with image inside
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Optional Image in status box
                    if (imagePath != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath!,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    Text(
                      statusTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      statusValue,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onStartPressed,
                  icon: const Icon(Icons.play_arrow_rounded, size: 18),
                  label: const Text("Start Baseline Assessment"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
