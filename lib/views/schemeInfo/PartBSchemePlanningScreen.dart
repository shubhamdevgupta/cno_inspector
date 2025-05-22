import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
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
                              "B.	Scheme Planning",
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
                              questionText: "1.	Has the surveys done for planning of the scheme :",
                              options: ['Topographical survey', 'GPS/physical survey done', 'Google Earth/Maps survey', 'No survey done'],
                              selectedValues: selectedInstitutions,
                              onChanged: (newSelected) {
                                setState(() {
                                  selectedInstitutions = newSelected;
                                });
                              },
                            ),




                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Align text to the left
                              children: [
                                CustomTextField(
                                  labelText: "2.What are the running hours per day considered for designing of WTP/Transmission main?",
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                SizedBox(
                                  height: 18,
                                ),

                                CustomTextField(
                                  labelText: '3.1 What is the retention time in hours per day considered for design of OHSR/OHT/ESR   ',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                SizedBox(
                                  height: 18,
                                ),

                                CustomTextField(
                                  labelText: '3.2 What is the retention time in hours per day considered for design of MBR',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),

                                CustomTextField(
                                  labelText: '4.1 Please specify the pipe material used for transmission pipeline and distribution network in Rocky Strata with reasons for selecting the same',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),
                             CustomTextField(
                                  labelText: '4.1 Please specify the pipe material used for transmission pipeline and distribution network in Soil Strata with reasons for selecting the same',
                                  hintText: 'Enter here',
                                  controller: householdController,
                                  isRequired: false,
                                ),


                              ],
                            ),



                            Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,
                                    child: Text("5.	Do the on-spot excavation on any sample stretch of pipeline and check for pipe material and dia as per DPR::",
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),)),
                                RadioListTile<String>(
                                  title: Text("Not Found"),
                                  value: 'option1',
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                                RadioListTile<String>(
                                  title: Text("Found as per DPR"),
                                  value: 'option2',
                                  groupValue: selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOption = value;
                                    });
                                  },
                                ),
                                if (selectedOption == 'option2') ...[
                                  TextField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                      labelText: "If deviation found",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
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
