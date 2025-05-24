import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionVWSC/GrievancePartE.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/customtxtfeild.dart';
import 'DashboardVWSC.dart';
import 'VWSCCommonClass.dart';

class WaterQualityPartD extends StatefulWidget {
  @override
  State<WaterQualityPartD> createState() => _WaterQualityPartD();
}

class _WaterQualityPartD extends State<WaterQualityPartD> {
// State variables (add inside your StatefulWidget's State):
  String? selectedFTKAvailability;  // Yes/No
  String? selectedFTKTestingFrequency; // Regularly tested / Occasionally / Not tested / No FTK
  TextEditingController womenTrainedController = TextEditingController();
  TextEditingController testerNameController = TextEditingController();
  String? selectedDisinfectionDone;  // Yes/No
  String? selectedFRCLevel;  // Available / Occasionally / Not Available / Not Tested

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
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/icons/header_bg.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Removes the default back button
            centerTitle: true,
            title: Text(
              "Water Quality Monitoring",
              style: AppStyles.appBarTitle,
            ),
            leading: IconButton(

              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboardvwsc()),
                        (route) => false,
                  );
                }
              },
            ),

            //elevation
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF096DA8), // Dark blue color
                    Color(0xFF3C8DBC), // Green color
                  ],
                  begin: Alignment.topCenter, // Start at the top center
                  end: Alignment.bottomCenter, // End at the bottom center
                ),
              ),
            ),
            elevation: 5,
          ),
          body: Stack(
            children: [

              SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Vwsccommonclass(
                        no: 4,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.lightGreen, width: 1.4),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Customradiobttn(
                                  question: "1. Availability of FTK:",
                                  options: ["Yes", "No"],
                                  selectedOption: selectedFTKAvailability,
                                  onChanged: (val) => setState(() => selectedFTKAvailability = val),
                                ),

                                Customradiobttn(
                                  question: "2. Water testing using FTKs:",
                                  options: ["Regularly tested", "Occasionally", "Not tested", "No FTK"],
                                  selectedOption: selectedFTKTestingFrequency,
                                  onChanged: (val) => setState(() => selectedFTKTestingFrequency = val),
                                ),

                                Customtxtfeild(
                                  label: "3. Number of women trained in water testing through FTKs:",
                                  controller: womenTrainedController,
                                  keyboardType: TextInputType.number,
                                ),

                                Customtxtfeild(
                                  label: "4. Who is doing the water quality testing through FTKs:",
                                  controller: testerNameController,
                                ),

                                Customradiobttn(
                                  question: "5. Disinfection/chlorination done:",
                                  options: ["Yes", "No"],
                                  selectedOption: selectedDisinfectionDone,
                                  onChanged: (val) => setState(() => selectedDisinfectionDone = val),
                                ),

                                Customradiobttn(
                                  question: "6. Free Residual Chlorine Level (FRC) at tail ends:",
                                  options: ["Available", "Occasionally", "Not Available", "Not Tested"],
                                  selectedOption: selectedFRCLevel,
                                  onChanged: (val) => setState(() => selectedFRCLevel = val),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightGreen,
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
                            )
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
