import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'PartBSchemePlanningScreen.dart';

class SourceScreenQuestions extends StatefulWidget {
  const SourceScreenQuestions({Key? key}) : super(key: key);

  @override
  _SourceScreenQuestions createState() => _SourceScreenQuestions();
}

class _SourceScreenQuestions extends State<SourceScreenQuestions> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  final TextEditingController householdController = TextEditingController();

  String? SetFreq;

  String? selectedValueQ2;
  String? selectedValueQ3;

  final TextEditingController safeController = TextEditingController();
  final TextEditingController criticalController = TextEditingController();
  final TextEditingController semiCriticalController = TextEditingController();
  final TextEditingController waterAllocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardschemeinfo()),
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
              "Source",
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
                      NewScreenPoints(
                        no: 1,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue, width: 1.4),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Customradiobttn(
                                question: '1. If the source is surface water, then, did the Source finding committee recommend the shift to surface water?',
                                options: const ['Yes', 'No'],
                                selectedOption: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),

                              // 2. Study done to assess ground water before going for surface water? (Yes/No)
                              Customradiobttn(
                                question: '2. Any study done to assess ground water before going for surface water?',
                                options: const ['Yes', 'No'],
                                selectedOption: selectedValueQ2,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ2 = val;
                                  });
                                },
                              ),

                              // 3. Number of villages falling under critical zones
                              const Text(
                                '3. Number of villages falling under the critical zones as mentioned (https://cgwb.gov.in/en/ground-water-resource-assessment-0):',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'Safe (Nos)',
                                controller: safeController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'Critical / Over exploited (Nos)',
                                controller: criticalController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'Semi-critical (Nos)',
                                controller: semiCriticalController,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 12),

                              // 4. Groundwater contamination analysis? (Yes/No)
                              Customradiobttn(
                                question: '4. In case of groundwater contamination, was any analysis conducted to determine the most techno-economical option — treating the contaminated groundwater or switching to a surface water source?',
                                options: const ['Yes', 'No'],
                                selectedOption: selectedValueQ3,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ3 = val;
                                  });
                                },
                              ),

                              // 5. Water allocation from State WRD / Irrigation Department (text input)
                              Customtxtfeild(
                                label: '5. Water allocation from the State Water Resource Department (WRD)/ Irrigation Department (ID) from surface source for drinking purpose',
                                controller: waterAllocationController,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 15),
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
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SchemePlanningScreen()),);

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
