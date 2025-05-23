import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'PartACoordinationPlanningReviewScreen.dart';
import 'PartCMonitoringQualityLabInfrastructure.dart';
import 'PartDOperationMaintenance.dart';
import 'PartGPublicComplaintsGrievance.dart';

class PartFQualityAssuranceCommissioning extends StatefulWidget {
  const PartFQualityAssuranceCommissioning({Key? key}) : super(key: key);

  @override
  _PartFQualityAssuranceCommissioning createState() => _PartFQualityAssuranceCommissioning();
}

class _PartFQualityAssuranceCommissioning extends State<PartFQualityAssuranceCommissioning> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  final TextEditingController householdController = TextEditingController();
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();
  String? SetFreq;

  List<String> selectedInstitutions = [];


  bool isWaterCharged = false;
  TextEditingController feeController = TextEditingController();
  String? chargeType; // 'Uniform' or 'Volumetric'
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => PartDOperationMaintenance()),
        );
        // Return false to prevent the default back navigation behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Part-2F Interaction with DWSM ',
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
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "F. Quality Assurance and Commissioning",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.orange),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              color: Colors.black38, // Color of the line
                              height: 1.0,
                              width: double.infinity, // Thickness of the line
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            CustomCheckboxQuestion(
                              questionText: "1.	Who all are authorized to inspect, and measure works during field inspection? ",
                              options: ['PHED Engineer ', 'PMC/PMU', 'TPIA', 'VWSC','Contractor Representative','others'],
                              selectedValues: selectedInstitutions,
                              onChanged: (newSelected) {
                                setState(() {
                                  selectedInstitutions = newSelected;
                                });
                              },
                            ),


                            CustomRadioQuestion(
                              questionText: "2.	Is the commissioning protocol being followed?",
                              options: const ['Yes', 'No'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),

                            CustomCheckboxQuestion(
                              questionText: "3.	During commissioning of schemes, who are generally present?",
                              options: ['PHED', 'VWSC Members', 'PRI Representatives', 'ISA','TPIA','Community Members'],
                              selectedValues: selectedInstitutions,
                              onChanged: (newSelected) {
                                setState(() {
                                  selectedInstitutions = newSelected;
                                });
                              },
                            ),

                            CustomCheckboxQuestion(
                              questionText: "4.	Has the district undertaken any assessment of third-party inspection agencies on quality checks for JJM schemes?",
                              options: const ['Yes – Regularly', 'Occasionally', 'Not Done'],
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
                                               Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartGPublicComplaintsGrievance()),);
                                        },
                                        child: const Text(
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
