import 'package:cno_inspection/views/schemeInfo/Dashboardschemeinfo.dart';
import 'package:cno_inspection/views/schemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/schemeInfo/PartASourceScreen.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import '../../utils/CustomTextField.dart';
import '../../utils/MultiSelectionlist.dart';
import '../../utils/customradiobttn.dart';
import '../../utils/customtxtfeild.dart';
import 'PartBSchemePlanningScreen.dart';
import 'PartEVisual Inspection.dart';
import 'SchemeInfoCommonScreen.dart';

class SchemeImplementationScreen extends StatefulWidget {
  const SchemeImplementationScreen({Key? key}) : super(key: key);

  @override
  _SchemeImplementationScreen createState() => _SchemeImplementationScreen();
}

class _SchemeImplementationScreen extends State<SchemeImplementationScreen> {
  final TextEditingController dateApprovalController = TextEditingController();
  final TextEditingController admissibleCostController = TextEditingController();

  // Selected values
  List<String> delayReasons = [];
  String? costOverrun;
  List<String> costOverrunReasons = [];
  String? revisedCostApproved;
  String? increaseInCost;
  List<String> revisionReasons = [];
  // For question 8 (yes/no for each component)
  final Map<String, String?> schemeMapping = {
    '8.1 WTP': null,
    '8.2 OHSR/GSR/OHT/ESR/MBR': null,
    '8.3 Source': null,
    '8.4 Pipeline': null,
  };
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Replace the current route with a new one
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => Dashboardschemeinfo()),
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
              "Scheme implementation",
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
                      Schemeinfocommonscreen(
                        no: 4,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(color: Colors.lightGreen, width: 1.4),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomMultiSelectChipQuestion(
                                question: '1. Reason(s) for delay after award of work:',
                                options: [
                                  'Delay in DPR approval',
                                  'Contractor delay',
                                  'Design changes during execution',
                                  'Material shortage',
                                  'Land/site issues',
                                  'Weather/natural calamities',
                                  'Inter-departmental coordination',
                                  'Others',
                                  'Clearances from Highway/Forest/Railways etc.',
                                ],
                                selectedValues: delayReasons,
                                onSelectionChanged: (values) {
                                  setState(() => delayReasons = values);
                                },
                              ),
                              const SizedBox(height: 10),

                              Customradiobttn(
                                question: '2. Cost overrun:',
                                options: ['<10%', '10–25%', '>25%', 'No overrun'],
                                selectedOption: costOverrun,
                                onChanged: (value) {
                                  setState(() => costOverrun = value);
                                },
                              ),

                              CustomMultiSelectChipQuestion(
                                question: '3. Reason(s) for cost overrun:',
                                options: [
                                  'Price escalation of materials',
                                  'Additional scope of work added post-DPR',
                                  'Delay in project execution leading to cost inflation',
                                  'Revision in technical design/specifications',
                                  'Change in site conditions or unforeseen site challenges',
                                  'Contractor claim settlement/additional payments',
                                  'Logistic/transportation constraints',
                                  'Poor estimation at DPR stage',
                                  'Others',
                                ],
                                selectedValues: costOverrunReasons,
                                onSelectionChanged: (values) {
                                  setState(() => costOverrunReasons = values);
                                },
                              ),

                              Customradiobttn(
                                question:
                                '4. Has the scheme approved cost been revised before award of work:',
                                options: ['Yes', 'No'],
                                selectedOption: revisedCostApproved,
                                onChanged: (value) {
                                  setState(() => revisedCostApproved = value);
                                },
                              ),

                              const Text(
                                '5.	Whether revised cost have been approved by SLSSC?',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                                Customradiobttn(
                                  question: '5.1 If yes, increase in cost: ',
                                  options: ['<10%', '10–25%', '>25%'],
                                  selectedOption: increaseInCost,
                                  onChanged: (value) {
                                    setState(() => increaseInCost = value);
                                  },
                                ),
                                Customtxtfeild(
                                  label:
                                  '5.2 Date of SLSSC approval in seriatim for revised estimate?',
                                  controller: dateApprovalController,
                                  keyboardType: TextInputType.datetime,
                                  hintText: 'dd-mm-yyyy',
                                ),


                              CustomMultiSelectChipQuestion(
                                question: '6. Reason(s) for revision:',
                                options: [
                                  'Price rise of materials',
                                  'Additional scope of work',
                                  'Change in site conditions',
                                  'Others',
                                ],
                                selectedValues: revisionReasons,
                                onSelectionChanged: (values) {
                                  setState(() => revisionReasons = values);
                                },
                              ),

                              const SizedBox(height: 10),
                              const Text(
                                '7. What is the admissible cost of the components (CAPEX) in the scheme?',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),

                              _buildAdmissibleCostTable(),

                              const SizedBox(height: 20),
                              const Text(
                                '8. Components of scheme planned or mapped on the PM-Gati Shakti?',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),


                              ...schemeMapping.keys.map((component) {
                                return Customradiobttn(
                                  question: component,
                                  options: ['Yes', 'No'],
                                  selectedOption: schemeMapping[component],
                                  onChanged: (value) {
                                    setState(() => schemeMapping[component] = value);
                                  },
                                );
                              }),

                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Adjust the radius as needed
                                      ),
                                    ),
                                    onPressed: () async {

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
      ),
    );
  }

  Widget _buildAdmissibleCostTable() {
    final columns = ['Components', 'Unit', 'Capacity', 'Cost (in cr.)'];
    final rows = [
      ['Intake/Tubewell', 'Nos.', 'In LPM', ''],
      ['Electromechanical components', 'Nos.', 'Head and discharge', ''],
      ['WTP', 'Nos.', 'In KLD', ''],
      ['MBR', 'Nos.', 'In KL', ''],
      ['Transmission pipeline', 'Dia of pipe', 'Length in Kms', ''],
      ['Distribution pipeline', 'Dia of pipe', 'Length in Kms', ''],
      ['OHSR/ESR/OHT/GSR', 'Nos.', 'In KL', ''],
      ['Disinfection unit', 'Nos.', 'In KLD', ''],
      ['IoT/SCADA', 'Nos.', '-', ''],
      ['Road Restoration', 'Nos.', 'Length in Kms', ''],
      ['Solar components', 'Nos.', '-', ''],
      ['Others (DG sets, HH storage)', 'Nos.', '-', ''],
    ];

    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: columns
              .map((col) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              col,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ))
              .toList(),
        ),
        ...rows.map((row) {
          return TableRow(
            children: row.map((cell) {
              if (cell == '') {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(cell),
                );
              }
            }).toList(),
          );
        }),
      ],
    );
  }

  void _saveFormData() {
    // Collect all data from the form here and process/save
    debugPrint('Delay reasons: $delayReasons');
    debugPrint('Cost overrun: $costOverrun');
    debugPrint('Cost overrun reasons: $costOverrunReasons');
    debugPrint('Revised cost approved: $revisedCostApproved');
    debugPrint('Increase in cost: $increaseInCost');
    debugPrint(
        'Date of SLSSC approval: ${dateApprovalController.text}');
    debugPrint('Revision reasons: $revisionReasons');
    debugPrint('Scheme mapping: $schemeMapping');
    // Show snackbar for demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form data saved!')),
    );
  }
}
