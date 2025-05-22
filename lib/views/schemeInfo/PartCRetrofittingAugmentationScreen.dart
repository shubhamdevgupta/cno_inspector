import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'PartDSchemeImplementationScreen.dart';
import 'PartBSchemePlanningScreen.dart';

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
                              "C.Additional information for Retrofitting/Augmentation Schemes only",
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


                            CustomRadioQuestion(
                              questionText: "1.	Whether the condition assessment of the legacy infrastructure done before scheme planning?",
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


                            CustomRadioQuestion(
                              questionText: "3. Is the as built drawing of the new infrastructure in conjunction with the existing infrastructure available with the department/agency/GP? Has it been digitized and uploaded on PM Gatishakti?",
                              options: const ['Yes', 'No'], // You can pass more options if needed
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
