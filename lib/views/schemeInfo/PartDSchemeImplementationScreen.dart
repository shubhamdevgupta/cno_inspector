import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'PartBSchemePlanningScreen.dart';
import 'PartEVisual Inspection.dart';

class SchemeImplementationScreen extends StatefulWidget {
  const SchemeImplementationScreen({Key? key}) : super(key: key);

  @override
  _SchemeImplementationScreen createState() => _SchemeImplementationScreen();
}

class _SchemeImplementationScreen extends State<SchemeImplementationScreen> {
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
          MaterialPageRoute(builder: (_) => RetrofittingAugmentationScreen()),
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
                        no: 4,
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
                                  "D.	Scheme implementation",
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
                                  questionText: "1.	What are the reason(s) for delay after award of work: Please select that are relatable:-",
                                  options: ['Delay in DPR approval ', 'Land/site issues ', 'Clearances from Highway/ Forest/ ', 'Contractor delay ',
                                  'Weather/natural calamities','Design changes during execution','Inter-departmental coordination',
                                  'Material shortage','Others'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),



                          CustomRadioQuestion(
                                  questionText: "2.	Cost overrun ?",
                                  options: const ['<10% ', '10–25% ','>25% ','No overrun'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),

                        CustomCheckboxQuestion(
                          questionText: "3.	Reason(s) for cost overrun (Select all that apply):",
                          options: ['Price escalation of materials', 'Logistic/transportation constraints','Additional scope of work added',
                          'Poor estimation at DPR stage','Delay in project execution leading','Revision in technical design',
                          'Change in site conditions or','Contractor claim settlement','Others'],

                          selectedValues: selectedInstitutions,
                          onChanged: (newSelected) {
                            setState(() {
                              selectedInstitutions = newSelected;
                            });
                          },
                        ),


                                CustomRadioQuestion(
                                  questionText: "4.	Has the scheme approved cost been revised before award of work: ?",
                                  options: const ['Yes', 'No'], // You can pass more options if needed
                                  selectedValue: selectedValueQ1,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedValueQ1 = val;
                                    });
                                  },
                                ),


                                Column(
                                  children: [
                                    Align(alignment: Alignment.centerLeft,
                                        child: Text("5.	Whether revised cost have been approved by SLSSC?",
                                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),)),
                                    RadioListTile<String>(
                                      title: Text("No"),
                                      value: 'option1',
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOption = value;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      title: Text("Yes"),
                                      value: 'option2',
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOption = value;
                                        });
                                      },
                                    ),
                                    if (selectedOption == 'option2') ...[
                                      CustomRadioQuestion(
                                        questionText: "5.1 If yes :",
                                        options: const ['<10%', '10–25%','>25%'], // You can pass more options if needed
                                        selectedValue: selectedValueQ1,
                                        onChanged: (val) {
                                          setState(() {
                                            selectedValueQ1 = val;
                                          });
                                        },
                                      ),

                                      //TODO : Date Selector add here

                                    ],
                                    SizedBox(height: 20),
                                    /*   ElevatedButton(
                                      onPressed: () {
                                        String result = selectedOption == 'option1'
                                            ? 'Selected: Option 1'
                                            : 'Selected: Option 2, Input: ${textController.text}';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text(result)));
                                      },
                                      child: Text("Submit"),
                                    ),*/
                                  ],
                                ),


                                CustomCheckboxQuestion(
                                  questionText: "6.	Reason(s) for revision (Select all that apply):",
                                  options: ['Price rise of materials','Additional scope of work ','Change in site conditions ','Others'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
                                    });
                                  },
                                ),




                                CustomCheckboxQuestion(
                                  questionText: "8.	Components of scheme planned or mapped on the PM-Gati Shakti?",
                                  options: ['WTP','OHSR/GSR/OHT/ESR/MBR','Source','Pipeline'],

                                  selectedValues: selectedInstitutions,
                                  onChanged: (newSelected) {
                                    setState(() {
                                      selectedInstitutions = newSelected;
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
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => VisualInspectionScreen()),);
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
