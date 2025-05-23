import 'package:cno_inspection/views/InteractionDWSM/DashboardDWSM.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import 'PartACoordinationPlanningReviewScreen.dart';
import 'PartCMonitoringQualityLabInfrastructure.dart';
import 'PartFQualityAssuranceCommissioning.dart';

class PartDOperationMaintenance extends StatefulWidget {
  const PartDOperationMaintenance({Key? key}) : super(key: key);

  @override
  _PartDOperationMaintenance createState() => _PartDOperationMaintenance();
}

class _PartDOperationMaintenance extends State<PartDOperationMaintenance> {
  String _selectedValue = 'yes'; // Default selected value
  String? selectedValueQ1;
  final TextEditingController householdController = TextEditingController();
  String? selectedOption = 'option1';
  final TextEditingController textController = TextEditingController();
  String? SetFreq;



  bool isWaterCharged = false;
  TextEditingController feeController = TextEditingController();
  String? chargeType; // 'Uniform' or 'Volumetric'
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => PartCMonitoringQualityLabInfrastructure()),
        );
        // Return false to prevent the default back navigation behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Part-2D Interaction with DWSM ',
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
                              "D(i.e  E). Operation & Maintenance (O&M)",
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

                            CustomRadioQuestion(
                              questionText: "1.	Is a protocol for handing over in-village infrastructure in place?",
                              options: const ['Yes', 'No','Partially'], // You can pass more options if needed
                              selectedValue: selectedValueQ1,
                              onChanged: (val) {
                                setState(() {
                                  selectedValueQ1 = val;
                                });
                              },
                            ),

                            CustomTextField(
                              labelText: '2.	Percentage of villages where trained multi-skilled manpower available for O&M: ',
                              hintText: 'Enter here',
                              controller: householdController,
                              isRequired: false,
                            ),





                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('3. Is water charged from households?'),
                              value: isWaterCharged,
                              onChanged: (value) {
                                setState(() {
                                  isWaterCharged = value ?? false;
                                  if (!isWaterCharged) {
                                    feeController.clear();
                                    chargeType = null;
                                  }
                                });
                              },
                            ),
                            if (isWaterCharged) ...[
                              SizedBox(height: 1),
                              TextFormField(
                                controller: feeController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Fee amount (₹ per month/per connection)',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                '3.1. Is it uniform or based on consumption?',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Uniform'),
                                value: 'Uniform',
                                groupValue: chargeType,
                                onChanged: (value) {
                                  setState(() => chargeType = value);
                                },
                              ),
                              RadioListTile<String>(
                                contentPadding: EdgeInsets.zero,
                                title: Text('Volumetric'),
                                value: 'Volumetric',
                                groupValue: chargeType,
                                onChanged: (value) {
                                  setState(() => chargeType = value);
                                },
                              ),
                            ],
                          ],
                        ),



                            CustomTextField(
                              labelText: '4. Percentage of villages where User Fee being is collected',
                              hintText: 'Enter here',
                              controller: householdController,
                              isRequired: false,
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
                                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => PartFQualityAssuranceCommissioning()),);
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
