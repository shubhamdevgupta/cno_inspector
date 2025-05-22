import 'package:cno_inspection/utils/CustomCheckBoxQuestion.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityInvolvementPartB.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomRadioQuestion.dart';

class WaterSupplyPartA extends StatefulWidget {
  const WaterSupplyPartA({Key? key}) : super(key: key);

  @override
  _WaterSupplyPartA createState() => _WaterSupplyPartA();
}

class _WaterSupplyPartA extends State<WaterSupplyPartA> {
  String? selectedValueQ1;
  String? SetFreq;
  List<String> selectedInstitutions = [];

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
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'SWM',
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
                              "Water Supply Functionality",
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
                              questionText: "1.	Water supply frequency?",
                              options: [
                                'Daily',
                                'Once in two days',
                                ' Once in three days ',
                                'Irregular',
                                'Not functional'
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                                  "2.	Is adequate water quantity reaching all the households: ",
                              options: ['Yes', 'No'],
                              // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                                  "3.	Is adequate water quantity reaching to remote/SC/ST/PVTG groups: ",
                              options: ['Yes', 'No'],
                              // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                                  "4.	Whether water reaches tail-end households: ",
                              options: [
                                'Yes – Consistently',
                                'Occasionally',
                                'No',
                                'Not Verified'
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomRadioQuestion(
                              questionText:
                                  "5.	Scheme operational status since commissioning: ",
                              options: [
                                'Fully operational >3 months ',
                                'Operational but with interruptions',
                                'Non-functional',
                                'Partially commissioned'
                              ], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),
                            CustomCheckboxQuestion(
                              questionText:
                                  "6. Whether piped water supply services available at institutions:",
                              options: [
                                'Schools',
                                'Anganwadi’s',
                                'PHCs',
                                'Not Applicable'
                              ],
                              selectedValues: selectedInstitutions,
                              onChanged: (newSelected) {
                                setState(() {
                                  selectedInstitutions = newSelected;
                                });
                              },
                            ),

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
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityInvolvementPartB()),);
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
    );
  }
}
