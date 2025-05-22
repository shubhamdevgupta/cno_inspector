import 'package:cno_inspection/views/schemeInfo/SourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomRadioQuestion.dart';

class SchemePlanningScreen extends StatefulWidget {
  const SchemePlanningScreen({Key? key}) : super(key: key);

  @override
  _SchemePlanningScreen createState() => _SchemePlanningScreen();
}

class _SchemePlanningScreen extends State<SchemePlanningScreen> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;

  final List<String> _dropdownOptions = [
    'Atleast once in 7 days',
    'Atleast once in 15 days',
    'Atleast once in more than 15 days'
  ];
  String? SetFreq;

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
                            Text(
                              "1.	Has the surveys done for planning of the scheme ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomRadioQuestion(
                                questionText: "1.1	Topographical survey",
                                options: const ['Yes', 'No'], // You can pass more options if needed
                                selectedValue: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomRadioQuestion(
                                questionText: "1.2.	GPS/physical survey done",
                                options: ['Yes', 'No'], // You can pass more options if needed
                                selectedValue: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomRadioQuestion(
                                questionText: "1.3.Google Earth/Maps survey	",
                                options: ['Yes', 'No'], // You can pass more options if needed
                                selectedValue: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomRadioQuestion(
                                questionText: "1.4.	No survey done	",
                                options: ['Yes', 'No'], // You can pass more options if needed
                                selectedValue: selectedValueQ1,
                                onChanged: (val) {
                                  setState(() {
                                    selectedValueQ1 = val;
                                  });
                                },
                              ),
                            ),

                            CustomRadioQuestion(
                              questionText: "2.	What are the running hours per day considered for designing of WTP/Transmission main?",
                              options: ['Safe', 'Critical / Over exploited','Semi-critical'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText: "3.	What is the retention time in hours per day considered for design of ",
                              /*o	OHSR/OHT/ESR			:	hrs.
o	MBR				:	hrs.
*/
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
                         /* Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GWMQuestions()),);*/
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
