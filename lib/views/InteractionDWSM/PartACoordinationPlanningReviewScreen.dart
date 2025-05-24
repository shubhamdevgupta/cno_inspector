import 'package:cno_inspection/utils/customradiobttn.dart';
import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customtxtfeild.dart';
import '../schemeInfo/PartBSchemePlanningScreen.dart';
import 'DWSMCommonClass.dart';
import 'PartBSourceSustainabilityWaterConservation.dart';


class CoordinationPlanningReview extends StatefulWidget {
  const CoordinationPlanningReview({Key? key}) : super(key: key);

  @override
  _CoordinationPlanningReview createState() => _CoordinationPlanningReview();
}

class _CoordinationPlanningReview extends State<CoordinationPlanningReview> {
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
          MaterialPageRoute(builder: (_) => Dashboarddwsm()),
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
              "Coordination, Planning & Review Mechanism",
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
                      Dwsmcommonclass(
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
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Customradiobttn(
                                question: 'Are monthly DWSM meetings on progress of JJM works being held?',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueQ1 = value;
                                  });
                                },
                                selectedOption: selectedValueQ1,
                              ),
                              if (selectedValueQ1 == 'Yes') ...[
                                const SizedBox(height: 8),
                                Customtxtfeild(
                                  label: 'How many meetings were held in the last six months?',
                                  controller: textController,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 8),
                                CustomCheckBoxQuestion(
                                  question: 'Quality of Meeting and Record maintenance:',
                                  options: const [
                                    'Proper Documentation with actionable decision',
                                    'Partial Documentation',
                                    'Not Documented'
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                  selectedValue: selectedOption,
                                ),
                              ],
                              const SizedBox(height: 16),
                              CustomCheckBoxQuestion(
                                question: 'Are District Development Coordination and Monitoring Committee (DISHA) meetings being held regularly?',
                                options: const ['Yes', 'No'],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue = value ?? '';
                                  });
                                },
                                selectedValue: _selectedValue,
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SourceSustainablitiyWasterConservation()),);

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
