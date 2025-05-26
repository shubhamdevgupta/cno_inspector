import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String baselineStatus;
  final VoidCallback onStartPressed;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.baselineStatus,
    required this.onStartPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.blue, width: 1.5),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusColumn("Baseline", baselineStatus, Colors.orangeAccent),
                  _statusColumn("Latest", "Pending", Colors.redAccent),
                  _statusColumn("ODF Status", "Non-ODF Plus", Colors.redAccent),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onStartPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Start Baseline Assessment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusColumn(String title, String value, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.circle, size: 16, color: iconColor),
            SizedBox(width: 6),
            Text(value,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}
