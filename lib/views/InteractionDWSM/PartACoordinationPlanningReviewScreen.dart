import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';

class CoordinationPlanningScreen extends StatefulWidget {
  const CoordinationPlanningScreen({Key? key}) : super(key: key);

  @override
  _CoordinationPlanningScreen createState() => _CoordinationPlanningScreen();
}

class _CoordinationPlanningScreen extends State<CoordinationPlanningScreen> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  final TextEditingController householdController = TextEditingController();
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();
  String? SetFreq;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboarddwsm()),
        );
        // Return false to prevent the default back navigation behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Part-2 Interaction with DWSM ',
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
                              "A. Coordination, Planning & Review Mechanism",
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


                            Column(
                              children: [
                                Align(alignment: Alignment.centerLeft,
                                    child: Text("1. Are monthly DWSM meetings on progress of JJM works being held?",
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
                                SizedBox(height: 5),
                                if (selectedOption == 'option2') ...[
                                  TextField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                      labelText: "(a). how many meetings were held in the last six months? ",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),

                                  SizedBox(height: 20),

                                  CustomRadioQuestion(
                                    questionText: "(b). Quality of Meeting and Record maintenance: ",
                                    options: const ['Proper Documentation with actionable decision', 'Partial Documentation','No Documentation'], // You can pass more options if needed
                                    selectedValue: selectedValueQ1,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedValueQ1 = val;
                                      });
                                    },
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

                            CustomRadioQuestion(
                              questionText: "2.	Are District Development Coordination and Monitoring Committee (DISHA) meetings being held regularly? ",
                              options: const ['Yes', 'No',], // You can pass more options if needed
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
                         // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => SchemePlanningScreen()),);
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
