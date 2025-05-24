import 'package:cno_inspection/utils/customtxtfeild.dart';
import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartDSchemeImplementationScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customradiobttn.dart';
import 'PartBSchemePlanningScreen.dart';
import 'SchemeInfoCommonScreen.dart';

class VisualInspectionScreen extends StatefulWidget {
  const VisualInspectionScreen({Key? key}) : super(key: key);

  @override
  _VisualInspectionScreen createState() => _VisualInspectionScreen();
}

class _VisualInspectionScreen extends State<VisualInspectionScreen> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();
  // Inside your state class:
  String? selected1;
  String? selected2;
  String? selected15;
  String? selected16;
  String? selected17;
  String? selected18;
  String? selected19;
  String? selectedIssue;
  String? selected21;
  String? selected22;
  String? selected27;
  String? selected28;



  String? SetFreq;
  List<String> selectedInstitutions = [];
  final TextEditingController householdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => SchemeImplementationScreen()),
        );

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
              "Visual Inspection",
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
                    MaterialPageRoute(builder: (context) => Dashboardschemeinfo()),
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
                  padding: const EdgeInsets.only(
                      top: 20, left: 6, right: 6, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Schemeinfocommonscreen(
                        no: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
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
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const Text(
                                  "Note: A walk-through to inspect various components of scheme to be carried out (Photographs to highlight deficiencies to be taken).",
                                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                                ),
                                const Divider(height: 20),

                                // Section 1(a) - WTP/OHSR/ESR...
                                const Text("1. Through visual inspection, are there signs of poor workmanship as mentioned:", style: TextStyle(fontWeight: FontWeight.w600)),
                                CustomCheckBoxQuestion(
                                  question: " Spalling (peeling off surface)",
                                  options: ['Yes', 'No'],
                                  selectedValue: selected1,
                                  onChanged: (val) => setState(() => selected1 = val),
                                ),
                                CustomCheckBoxQuestion(
                                  question: "Cracks",
                                  options: ['Yes', 'No'],
                                  selectedValue: selected2,
                                  onChanged: (val) => setState(() => selected2 = val),
                                ),
                                // Repeat for all points in 1(a)...

                                const SizedBox(height: 10),
                                const Text("1(b). Inspection of Pipelines:", style: TextStyle(fontWeight: FontWeight.w600)),
                                CustomCheckBoxQuestion(
                                  question: "Leakages in transmission pipelines/valves",
                                  options: ['Yes', 'No'],
                                  selectedValue: selected15,
                                  onChanged: (val) => setState(() => selected15 = val),
                                ),
                                // Repeat for 1(b)...

                                Customradiobttn(
                                  question: "2. Is third-party/State department verifying pipe quality?",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected16,
                                  onChanged: (val) => setState(() => selected16 = val),
                                ),

                                Customradiobttn(
                                  question: "3. Are pipe materials as per DPR implemented?",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected17,
                                  onChanged: (val) => setState(() => selected17 = val),
                                ),

                                Customradiobttn(
                                  question: "4. Any complaints regarding pipeline laying?",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected18,
                                  onChanged: (val) => setState(() => selected18 = val),
                                ),

                                Customradiobttn(
                                  question: "5. Is TPIA engaged for this scheme?",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected19,
                                  onChanged: (val) => setState(() => selected19 = val),
                                ),

                                Customradiobttn(
                                  question: "6.	Are sample based quality checks being done from third party labs for pipes, civil works, and key components (if yes, random reports to be seen)",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected19,
                                  onChanged: (val) => setState(() => selected19 = val),
                                ),

                                Customradiobttn(
                                  question: "7.	Is concurrent supervision in the scope of TPIA? ",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected19,
                                  onChanged: (val) => setState(() => selected19 = val),
                                ),

                                Customradiobttn(
                                  question: "8.	Has TPIA conducted quality checks at different stages of construction? ",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected19,
                                  onChanged: (val) => setState(() => selected19 = val),
                                ),

                                Customradiobttn(
                                  question: "9.	Are there records of observations/inspection reports issued by TPIA?",
                                  options: ['Yes', 'No'],
                                  selectedOption: selected19,
                                  onChanged: (val) => setState(() => selected19 = val),
                                ),

                                // Continue similarly for all remaining questions...

                                CustomCheckBoxQuestion(
                                  question: "10. Serious issues observed by TPIAs:",
                                  options: [
                                    "Pipelines without proper depth",
                                    "Pipelines leaking",
                                    "OHT leaking",
                                    "Cracks in RCC works",
                                    "Water connections in drains",
                                    "Others"
                                  ],
                                  selectedValue: selectedIssue,
                                  onChanged: (val) => setState(() => selectedIssue = val),
                                ),

                                CustomCheckBoxQuestion(
                                  question: "11. Action based on TPIA observations",
                                  options: [
                                    "Rectification/Demolition Done",
                                    "Partial Action",
                                    "No Action",
                                    "Not Known"
                                  ],
                                  selectedValue: selected21,
                                  onChanged: (val) => setState(() => selected21 = val),
                                ),

                                CustomCheckBoxQuestion(
                                  question: "12. TPIA verifies Measurement Books?",
                                  options: ["Regularly", "Occasionally", "No", "Not Known"],
                                  selectedValue: selected22,
                                  onChanged: (val) => setState(() => selected22 = val),
                                ),


                                const Text(
                                  '13. Hydrotesting of pipelines done (reports to be seen)',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 6),
                                Customradiobttn(
                                  question: 'Transmission line',
                                  options: const ['Yes', 'No'],
                                  selectedOption: _selectedValue,
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedValue = val!;
                                    });
                                  },
                                ),
                                Customradiobttn(
                                  question: 'Distribution line',
                                  options: const ['Yes', 'No'],
                                  selectedOption: _selectedValue,
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedValue = val!;
                                    });
                                  },
                                ),



                                CustomCheckBoxQuestion(
                                  question: "14. Test reports provided (random samples to be seen)",
                                  options: [
                                    "Hydrotesting reports",
                                    "Construction material quality reports ",
                                    "Not Provided",
                                  ],
                                  selectedValue: selectedIssue,
                                  onChanged: (val) => setState(() => selectedIssue = val),
                                ),


                                CustomCheckBoxQuestion(
                                  question: "15. Whether departmental engineers do quality checks",
                                  options: [
                                    "Frequently ",
                                    "Stage-wise ",
                                    "Before payment ",
                                    "Never",
                                  ],
                                  selectedValue: selectedIssue,
                                  onChanged: (val) => setState(() => selectedIssue = val),
                                ),


                                CustomCheckBoxQuestion(
                                  question: "16. Whether departmental engineers (JE/AE/DE/EE etc.) are verifying measurements of construction works",
                                  options: [
                                    "Frequently ",
                                    "Stage-wise ",
                                    "Before payment ",
                                    "Never",
                                  ],
                                  selectedValue: selectedIssue,
                                  onChanged: (val) => setState(() => selectedIssue = val),
                                ),





                                // Final questions
                                CustomCheckBoxQuestion(
                                  question: "17. Scheme commissioned as per protocol?",
                                  options: ["Yes", "No", "Partially", "Not Verified", "Work is in progress"],
                                  selectedValue: selected27,
                                  onChanged: (val) => setState(() => selected27 = val),
                                ),

                                CustomCheckBoxQuestion(
                                  question: "18. Document proof of commissioning available",
                                  options: ["Yes", "No", "NA"],
                                  selectedValue: selected28,
                                  onChanged: (val) => setState(() => selected28 = val),
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
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Dashboardschemeinfo()),);

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
                            ),

                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
