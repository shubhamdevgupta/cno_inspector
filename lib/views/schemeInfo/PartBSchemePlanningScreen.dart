import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'PartCRetrofittingAugmentationScreen.dart';

class SchemePlanningScreen extends StatefulWidget {
  const SchemePlanningScreen({Key? key}) : super(key: key);

  @override
  _SchemePlanningScreen createState() => _SchemePlanningScreen();
}

class _SchemePlanningScreen extends State<SchemePlanningScreen> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();

  final List<String> _dropdownOptions = [
    'Atleast once in 7 days',
    'Atleast once in 15 days',
    'Atleast once in more than 15 days'
  ];
  String? SetFreq;
  List<String> selectedInstitutions = [];
  final TextEditingController householdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
           Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => SourceScreenQuestions()),
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
              "Scheme Inspection",
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
                        no: 2,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.orangeAccent, width: 1.4),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'B. Scheme Planning',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),

                              // 1. Survey questions
                              const Text(
                                '1. Has the surveys done for planning of the scheme:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),

                              CustomCheckBoxQuestion(
                                question: 'Topographical survey',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                setState(() {
                                  _selectedValue = value ?? '';
                                });
                              },
                              ),
                              CustomCheckBoxQuestion(
                                question: 'GPS/physical survey done',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value ?? '';
                                  });
                                },
                              ),
                              CustomCheckBoxQuestion(
                                question: 'Google Earth/Maps survey',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value ?? '';
                                  });
                                },
                              ),
                              CustomCheckBoxQuestion(
                                question: 'No survey done',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value ?? '';
                                  });
                                },
                              ),
                              const SizedBox(height: 10),

                              // 2. WTP design hours
                              Customtxtfeild(
                                label: '2. Running hours per day considered for WTP/Transmission main (hrs)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),

                              // 3. Retention time
                              const Text(
                                '3. Retention time considered for design:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Customtxtfeild(
                                label: 'OHSR/OHT/ESR (in hrs)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 6),
                              Customtxtfeild(
                                label: 'MBR (in hrs)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),

                              // 4. Pipe material selection
                              const Text(
                                '4. Selection of pipe material with reasons:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Customtxtfeild(
                                label: 'Rocky Strata - Pipe Material Used',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 6),
                              Customtxtfeild(
                                label: 'Soil Strata - Pipe Material Used',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 10),

                              // 5. On-spot excavation check
                              const Text(
                                '5. On-spot excavation and DPR check:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Customradiobttn(
                                question: 'Your question here?',
                                options: const ['Yes', 'No'],
                                selectedOption: _selectedValue,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedValue = val!;
                                  });
                                },
                              ),

                              Customtxtfeild(
                                label: 'If deviation found, provide reason',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 20),

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
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => RetrofittingAugmentationScreen()),);

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
