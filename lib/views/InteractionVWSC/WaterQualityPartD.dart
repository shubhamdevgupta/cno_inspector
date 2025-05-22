import 'package:cno_inspection/views/InteractionVWSC/GrievancePartE.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/CustomRadioQuestion.dart';

class WaterQualityPartD extends StatefulWidget {
  @override
  State<WaterQualityPartD> createState() => _WaterQualityPartD();
}

class _WaterQualityPartD extends State<WaterQualityPartD> {
  String? selectedValueQ1;
  List<String> selectedInstitutions = [];
  String? selectedFrequency;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        /*   Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => VillageList()),
        );*/

        // Return false to prevent the default back navigation behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'SWM',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color(0xffb2B4E71),
          elevation: 5,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Water Quality Monitoring",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.orange),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Colors.black38, // Color of the line
                              height: 1.0,
                              width: double.infinity, // Thickness of the line
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomRadioQuestion(
                              questionText: "1.	Availability of FTK: ",
                              options: [
                                'Yes',
                                'No',
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText: "2.	Water testing using FTKs: ",
                              options: [
                                'Regularly tested ',
                                'Occasionally ',
                                'Not tested  ',
                                'No FTK ',
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                                  "3.	Number of women trained in water testing through FTKs: ",
                              options: [
                                'Yes',
                                'No',
                                'Partially',
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            Text(
                              '3.	Number of women trained in water testing through FTKs',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  hintText: "input ftk",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                )),
                            Text(
                              '4.	Who is doing the water quality testing through FTKs: ',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF5F7FA),
                                  hintText: "input ftk",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                )),
                            CustomRadioQuestion(
                              questionText:
                              "5.	Disinfection/chlorination done",
                              options: [
                                'Yes',
                                'No',
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                              "6.	Free Residual Chlorine Level (FRC) at tail ends: ",
                              options: [
                                'Available ',
                                'Occasionally ',
                                'Not Available  ',
                                'Not Tested ',
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffb0D6EFD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GrievancePartE()),);
                                  },
                                  child: Text(
                                    "SAVE & NEXT",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioGroup(
    String title,
    List<String> options,
    String? groupValue,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(title),
        ...options.map(
          (value) => RadioListTile<String>(
            title: Text(value),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0xFFF5F7FA),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
