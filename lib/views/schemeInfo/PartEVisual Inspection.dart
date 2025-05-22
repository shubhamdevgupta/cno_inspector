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
import 'PartBSchemePlanningScreen.dart';

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
              "Scheme Inspection Form",
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
                        no: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "E.	Visual Inspection",
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

                                CustomCheckboxQuestion(

                                  questionText: "1.	Through visual inspection, are there signs of poor workmanship as mentioned:\n(a)	Inspection of WTP/OHSR/ESR/GSR/MBR/Pump house:",
                                  options: const ['spalling (peeling off surface)','Cracks',
                                    'Red/brown rust marks','swollen concrete','trapped jute/plastic bags',
                                  'protruding rusted reinforcement bars',
                                    'dampness of concrete surfaces','visible white marks','visible stone aggregates'
                                    'structures missing vertical alignment'
                                  ,'visible sag in the slab/beam',
                                    'high vibration observed in the pumps',
                                    'leakages in reservoirs','high leakages from the pumps'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),

                                CustomCheckboxQuestion(

                                  questionText: "1.(b)	Inspection of WTP/OHSR/ESR/GSR/MBR/Pump house:",
                                  options: const ['leakages in transmission pipelines/valves','leakages in distribution pipelines/valves','wet patches/pool of water on the ground along the route of pipe'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "2.	Whether quality verification is being done by the third party or the State department during manufacturing of pipe (random quality checks reports to be seen)? ",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),

                                CustomRadioQuestion(
                                  questionText: "3.	Are the pipes as mentioned in the DPR (material such as HDPE, DI, etc., diameter) being implemented on ground (random check to be done)?",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "4.	Are there any complaints regarding pipeline laying as per the approved design as per DPR?",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "5.	Is TPIA engaged for this scheme? ",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),

                                CustomRadioQuestion(
                                  questionText: "6.	Are sample based quality checks being done from third party labs for pipes, civil works, and key components (if yes, random reports to be seen)",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "7.	Is concurrent supervision in the scope of TPIA? ",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "8.	Has TPIA conducted quality checks at different stages of construction? ",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "9.	Are there records of observations/inspection reports issued by TPIA? ",
                                  options: const ['Yes','No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                CustomCheckboxQuestion(

                                  questionText: "10.	Are there any serious issues observed by TPIAs about construction of schemes: If, yes, type of issues:",
                                  options: const ['Pipelines without proper depth/ cushion','Pipelines damages & leaking','OHT leaking',
                                'Cracks in RCC works', 'Water connections passing through drains','Others, please specify'
                                  ],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),


                                CustomRadioQuestion(
                                  questionText: "11.	Has any action been taken by the department based on TPIA observations?",
                                  options: const ['Yes – Rectification/Demolition Done','Yes – Partial Action','No Action','Not Known'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                CustomRadioQuestion(
                                  questionText: "12.	Does TPIA verify Measurement Books (MBs)? ",
                                  options: const ['Yes – Regularly','Yes – Occasionally','No','Not Known'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                CustomCheckboxQuestion(

                                  questionText: "13.	Hydrotesting of pipelines done (reports to be seen):",
                                  options: const ['Transmission line','Distribution line'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),



                                CustomCheckboxQuestion(

                                  questionText: "14.	Test reports provided (random samples to be seen)",
                                  options: const ['Hydrotesting reports','Construction material quality reports','Not Provided'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),



                                CustomRadioQuestion(
                                  questionText: "15.	Whether departmental engineers do quality checks ",
                                  options: const ['Frequently','Stage-wise','Before payment','Never'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                CustomRadioQuestion(
                                  questionText: "16.	Whether departmental engineers (JE/AE/DE/EE etc.) are verifying measurements of construction works",
                                  options: const ['Frequently','Stage-wise','Before payment','Never'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                CustomRadioQuestion(
                                  questionText: "17.	Scheme commissioned done as per commissioning protocol: ",
                                  options: const ['Yes','No','Partially ','Not Verified','Work is in progress'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                CustomRadioQuestion(
                                  questionText: "18.	Document as proof of commissioning available  ",
                                  options: const ['Yes','No','NA'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),



                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: 35,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xffb0D6EFD),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10), // Adjust the radius as needed
                                              ),
                                            ),
                                            onPressed: () {
                                            //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => VisualInspectionScreen()),);
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
                                )
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
