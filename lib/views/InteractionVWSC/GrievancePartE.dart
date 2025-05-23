import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/MultiSelectionlist.dart';
import 'DashboardVWSC.dart';

class GrievancePartE extends StatefulWidget {
  @override
  State<GrievancePartE> createState() => _GrievancePartE();
}

class _GrievancePartE extends State<GrievancePartE> {
  String? selectedGrievanceMechanism; // Yes / No

  List<String> grievanceRegistrationMethods = [];
  String? selectedTurnAroundTime; // Same day / Two days / Three days / More than three days

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
              "Grievance Redressal",
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
                      NewScreenPoints(
                        no: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green, width: 1.4),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.06),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. Grievance redressal mechanism available
                                Customradiobttn(
                                  question: "1. Grievance redressal mechanism available:",
                                  options: ["Yes", "No"],
                                  selectedOption: selectedGrievanceMechanism,
                                  onChanged: (val) => setState(() => selectedGrievanceMechanism = val),
                                ),

                                SizedBox(height: 16),

                                // 2. How grievances are registered by villagers (multi-select)
                                CustomMultiSelectChipQuestion(
                                  question: "2. How grievances are registered by the villagers:",
                                  options: [
                                    "Toll free number",
                                    "Web based portal",
                                    "Mobile application",
                                    "Public grievance registration center",
                                    "Directly calling to PHED/Contractor/O&M agency",
                                  ],
                                  selectedValues: grievanceRegistrationMethods,
                                  onSelectionChanged: (selectedList) {
                                    setState(() {
                                      grievanceRegistrationMethods = selectedList;
                                    });
                                  },
                                ),


                                SizedBox(height: 20),

                                // 3. Turn around time for grievance
                                Customradiobttn(
                                  question: "3. Turn around time for grievance:",
                                  options: ["Same day", "Two days", "Three days", "More than three days"],
                                  selectedOption: selectedTurnAroundTime,
                                  onChanged: (val) => setState(() => selectedTurnAroundTime = val),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Dashboardvwsc()),);

                                      },
                                      child: Text(
                                        "SAVE",
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
                            ,
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
