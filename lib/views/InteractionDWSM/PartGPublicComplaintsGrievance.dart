import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'PartACoordinationPlanningReviewScreen.dart';
import 'PartCMonitoringQualityLabInfrastructure.dart';
import 'PartDOperationMaintenance.dart';
import 'PartGPublicComplaintsGrievance.dart';

class PartGPublicComplaintsGrievance extends StatefulWidget {
  const PartGPublicComplaintsGrievance({Key? key}) : super(key: key);

  @override
  _PartGPublicComplaintsGrievance createState() => _PartGPublicComplaintsGrievance();
}

class _PartGPublicComplaintsGrievance extends State<PartGPublicComplaintsGrievance> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  final TextEditingController householdController = TextEditingController();
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();
  String? SetFreq;

  List<String> selectedInstitutions = [];


  String? grievanceAvailable; // 'Yes' or 'No'
  Set<String> grievanceChannels = {};
  String? complaintsReceived; // 'Yes' or 'No'
  Set<String> complaintTypes = {};
  TextEditingController otherComplaintController = TextEditingController();
  TextEditingController resolutionTimeController = TextEditingController();
  TextEditingController actionTakenController = TextEditingController();

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
            'Part-2G Interaction with DWSM ',
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
                              "G. Public Complaints and Grievance Redressal",
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







                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              CustomRadioQuestion(
                                questionText: "1. Grievance Redressal mechanism available:",
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

                              SizedBox(height: 16),
                              Text('Are complaints received from public regarding JJM schemes?'),
                              RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Yes'),
                                value: 'Yes',
                                groupValue: complaintsReceived,
                                onChanged: (val) => setState(() => complaintsReceived = val),
                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text('No'),
                                value: 'No',
                                groupValue: complaintsReceived,
                                onChanged: (val) => setState(() => complaintsReceived = val),
                              ),

                              if (complaintsReceived == 'Yes') ...[
                                SizedBox(height: 8),
                                Text('Type of complaints (tick all applicable):'),
                                buildCheckbox('Poor water quality', complaintTypes),
                                buildCheckbox('Incomplete connections', complaintTypes),
                                buildCheckbox('Delay in commissioning', complaintTypes),
                                buildCheckbox('No water supply', complaintTypes),
                                buildCheckbox('Faulty construction', complaintTypes),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: complaintTypes.contains('Others'),
                                      onChanged: (val) {
                                        setState(() {
                                          val! ? complaintTypes.add('Others') : complaintTypes.remove('Others');
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: otherComplaintController,
                                        decoration: InputDecoration(
                                          labelText: 'Others (specify)',
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: resolutionTimeController,
                                  decoration: InputDecoration(
                                    labelText: 'Average time of resolution',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  ),
                                ),
                                SizedBox(height: 12),
                                TextFormField(
                                  controller: actionTakenController,
                                  decoration: InputDecoration(
                                    labelText: 'Action taken by department',
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  ),
                                ),
                              ],
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
                                       //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GrievanceForm()),);
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


  Widget buildCheckbox(String label, Set<String> controllerSet) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: controllerSet.contains(label),
      onChanged: (val) {
        setState(() {
          val! ? controllerSet.add(label) : controllerSet.remove(label);
        });
      },
    );
  }
}
