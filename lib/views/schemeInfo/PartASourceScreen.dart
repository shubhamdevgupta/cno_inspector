import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
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
              "Waster Supply",
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
                                  "Field visit format for Central Nodal Officers",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
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
                                  questionText: "1.	If the source is surface water, then, did the Source finding committee recommended the shift to surface water? ",
                                  options: const ['Yes', 'No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),

                                CustomRadioQuestion(
                                  questionText: "2.Any study done to assess ground water before going for surface water?",
                                  options: ['Yes', 'No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // Align text to the left
                                  children: [
                                    CustomTextField(
                                      labelText: '3.1 number of villages falling under the SAFE zones as specified by CGWB',
                                      hintText: 'Enter here',
                                      controller: householdController,
                                      isRequired: false,
                                    ),

                                    SizedBox(
                                      height: 18,
                                    ),

                                    CustomTextField(
                                      labelText: '3.2 number of villages falling under the CRITICAL / OVER-EXPLOITED zones as specified by CGWB',
                                      hintText: 'Enter here',
                                      controller: householdController,
                                      isRequired: false,
                                    ),

                                    SizedBox(
                                      height: 18,
                                    ),

                                    CustomTextField(
                                      labelText: '3.3 number of villages falling under the  SEMI-CRITICAL  zones as specified by CGWB',
                                      hintText: 'Enter here',
                                      controller: householdController,
                                      isRequired: false,
                                    ),
                                  ],
                                ),


                                CustomRadioQuestion(
                                  questionText: "4.In case of groundwater contamination, was any analysis conducted to determine the most techno-economical option—treating the contaminated groundwater or switching to a surface water source? ",
                                  options: ['Yes', 'No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),
                                 CustomRadioQuestion(
                                  questionText: "5.	Water allocation from the State Water Resource Department (WRD)/ Irrigation Department (ID) from surface source for drinking purpose?",
                                  options: ['Yes', 'No'], // You can pass more options if needed
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
