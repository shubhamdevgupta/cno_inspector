import 'package:flutter/material.dart';

class CommunityInvolvementPartB extends StatefulWidget {
  final VoidCallback onNext;

  const CommunityInvolvementPartB({super.key, required this.onNext});

  @override
  State<CommunityInvolvementPartB> createState() => _CommunityInvolvementPartBState();
}

class _CommunityInvolvementPartBState extends State<CommunityInvolvementPartB> {
  String? vwscFormed;
  String? bankAccount;
  String? involvement;
  String? drawingAvailable;
  String? periodicMeetings;
  String? meetingFrequency = '';
  String? recordsAvailable;
  String? oAndMInvolvement;
  String? schemeHandedOver;
  String? oAndMArrangement;
  String? communityAwareness;
  String? communitySatisfaction;

  bool get isComplete {
    return vwscFormed != null &&
        bankAccount != null &&
        involvement != null &&
        drawingAvailable != null &&
        periodicMeetings != null &&
        recordsAvailable != null &&
        oAndMInvolvement != null &&
        schemeHandedOver != null &&
        oAndMArrangement != null &&
        communityAwareness != null &&
        communitySatisfaction != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Part B: Community Involvement")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRadioGroup("1. Is VWSC or Pani samiti formed:", ['Yes', 'No'], vwscFormed,
                    (val) => setState(() => vwscFormed = val)),

            buildRadioGroup("2. Is VWSC bank account opened:", ['Yes', 'No'], bankAccount,
                    (val) => setState(() => bankAccount = val)),

            buildRadioGroup("3. VWSC/GP involvement in scheme operations:", [
              'Active',
              'Limited',
              'No Involvement',
              'VWSC not formed'
            ], involvement, (val) => setState(() => involvement = val)),

            buildRadioGroup("4. As-built Drawing of Pipelines available with GP office:", ['Yes', 'No'],
                drawingAvailable, (val) => setState(() => drawingAvailable = val)),

            buildRadioGroup(
              "5. Are VWSC meetings conducted periodically?",
              ['Yes', 'No'],
              periodicMeetings,
                  (val) => setState(() => periodicMeetings = val),
            ),
            if (periodicMeetings == 'Yes')
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 16),
                child: TextField(
                  onChanged: (val) => meetingFrequency = val,
                  decoration: const InputDecoration(labelText: "Meeting Frequency (e.g., Monthly)"),
                ),
              ),

            buildRadioGroup("6. Records of VWSC meetings available:", ['Yes', 'No'], recordsAvailable,
                    (val) => setState(() => recordsAvailable = val)),

            buildRadioGroup("7. VWSC/GP involved in O&M:", [
              'Yes – Active',
              'Yes – Limited',
              'No',
              'Not Applicable'
            ], oAndMInvolvement, (val) => setState(() => oAndMInvolvement = val)),

            buildRadioGroup("8. Scheme handed over to GP/VWSC:", ['Yes', 'No', 'Not Applicable'],
                schemeHandedOver, (val) => setState(() => schemeHandedOver = val)),

            buildRadioGroup("9. O&M arrangements:", [
              'VWSC',
              'PHED',
              'Outsourced Contractor',
              'No arrangement'
            ], oAndMArrangement, (val) => setState(() => oAndMArrangement = val)),

            buildRadioGroup("10. Community awareness about scheme features:", [
              'Well informed',
              'Some awareness',
              'No awareness'
            ], communityAwareness, (val) => setState(() => communityAwareness = val)),

            buildRadioGroup("11. Community satisfaction with water quality:", [
              'Satisfied',
              'Partially Satisfied',
              'Dissatisfied',
              'Not Interacted'
            ], communitySatisfaction, (val) => setState(() => communitySatisfaction = val)),

            const SizedBox(height: 24),
            if (isComplete)
              ElevatedButton(
                onPressed: widget.onNext,
                child: const Text("Next: Part C"),
              )
          ],
        ),
      ),
    );
  }

  Widget buildRadioGroup(
      String title,
      List<String> options,
      String? groupValue,
      void Function(String?) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(title),
        ...options.map(
              (value) => RadioListTile<String>(
            title: Text(value),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
