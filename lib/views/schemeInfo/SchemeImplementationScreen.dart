import 'package:cno_inspection/views/schemeInfo/RetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/SourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'SchemePlanningScreen.dart';

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
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Part-1 Scheme Inspection Form.',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: Color(0xffb2B4E71),
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
                    Card(
                      elevation: 5,
                      child: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Align text to the left
                              children: [
                                CustomTextField(
                                  labelText: "2.1 Enter the length of Legacy Transmission Pipelines which has been retrofitted and being used in the scheme (KM) ",
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                SizedBox(
                                  height: 18,
                                ),

                                CustomTextField(
                                  labelText: '2.2 Enter the Length of Legacy Distribution Pipelines which has been retrofitted and being used in the scheme (KM) ',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                SizedBox(
                                  height: 18,
                                ),

                                CustomTextField(
                                  labelText: '2.3 Enter the Capacity of WTP which has been retrofitted and being used in the scheme (MLD) ',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                CustomTextField(
                                  labelText: '2.4 Enter the number of storage reservoirs and the capacity of each storage reservoir which has been retrofitted and being used in the scheme (in KL) ',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                              ],
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
                              ),
                            )
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
    );
  }
}
