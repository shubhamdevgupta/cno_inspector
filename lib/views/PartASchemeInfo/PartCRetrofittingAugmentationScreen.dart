import 'package:cno_inspection/views/PartASchemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/PartASchemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/customcheckquestion.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'PartDSchemeImplementationScreen.dart';
import 'PartBSchemePlanningScreen.dart';
import 'SchemeInfoCommonScreen.dart';

class RetrofittingAugmentationScreen extends StatefulWidget {
  const RetrofittingAugmentationScreen({Key? key}) : super(key: key);

  @override
  _RetrofittingAugmentationScreen createState() => _RetrofittingAugmentationScreen();
}

class _RetrofittingAugmentationScreen extends State<RetrofittingAugmentationScreen> {
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
          MaterialPageRoute(builder: (_) => SchemePlanningScreen()),
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
              "Additional info for Retrofitting/Augmentation Schemes only",
              style: AppStyles.appBarTitleSmallText,
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
                        no: 3,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.deepOrangeAccent, width: 1.4),
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
                                question: '1. Whether the condition assessment of the legacy infrastructure done before scheme planning?',
                                options: const ['Yes', 'No'],
                                selectedOption: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),
                              const SizedBox(height: 10),

                              // 2. Legacy infrastructure usage
                              const Text(
                                '2. Legacy infrastructure which has been retrofitted and being used in the scheme under JJM:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),

                              Customtxtfeild(
                                label: 'Transmission Pipelines (in Kms)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'Distribution Pipelines (in Kms)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'WTP Capacity (in MLD)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 8),

                              Customtxtfeild(
                                label: 'Storage Structures (Nos./Capacity in KL)',
                                controller: TextEditingController(),
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 10),
                              

                              // 3. As-built drawing availability
                              Customradiobttn(
                                question: '3. Is the as-built drawing of the new infrastructure in conjunction with the existing infrastructure available with the department/agency/GP? Has it been digitized and uploaded on PM Gatishakti?',
                                options: const ['Yes', 'No'],
                                selectedOption: selectedOption,
                                onChanged: (val) {
                                  setState(() {
                                    selectedOption = val;
                                  });
                                },
                              ),

                              const SizedBox(height: 20),

                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:Colors.deepOrangeAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SchemeImplementationScreen()),);

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
