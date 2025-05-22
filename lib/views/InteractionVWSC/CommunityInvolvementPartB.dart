import 'package:cno_inspection/views/InteractionVWSC/CommunityFeedbackPartC.dart';
import 'package:flutter/material.dart';

import '../../utils/AppStyles.dart';
import '../../utils/CommonScreen.dart';
import '../../utils/CustomCheckBoxQuestion.dart';
import '../../utils/CustomRadioQuestion.dart';
import 'DashboardVWSC.dart';

class CommunityInvolvementPartB extends StatefulWidget {


  @override
  State<CommunityInvolvementPartB> createState() => _CommunityInvolvementPartBState();
}

class _CommunityInvolvementPartBState extends State<CommunityInvolvementPartB> {
  String? selectedValueQ1;
  List<String> selectedInstitutions = [];
  String? selectedFrequency;

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
              "Waster Supply",
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
                    MaterialPageRoute(builder: (context) => Dashboardvwsc()),
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
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     NewScreenPoints(
                       no: 2,
                     ),
                     Padding(
                       padding: const EdgeInsets.all(2.0),
                       child: Card(
                         elevation: 5,
                         child: Container(
                           color: Colors.white,
                           padding: EdgeInsets.all(10),
                           width: double.infinity,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(
                                 height: 5,
                               ),
                               Text(
                                 "Community Involvement & VWSC Functionality",
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
                                 questionText: "1. Is VWSC or Pani samiti formed",
                                 options: [
                                   'Yes',
                                   'No',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "2.	Is VWSC bank account opened: ",
                                 options: [
                                   'Yes',
                                   'No',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "3.	VWSC/GP involvement in scheme operations: ",
                                 options: [
                                   'Active ',
                                   'Limited ',
                                   'No Involvement',
                                   'VWSC not formed',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "4.	As-built Drawing of Pipelines available with GP office: ",
                                 options: [
                                   'Yes',
                                   'No',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               //TODO if yes add new data
                               CustomRadioQuestion(
                                 questionText: "5.	Whether meetings of VWSC are conducted in a periodic manner? ",
                                 options: [
                                   'Yes',
                                   'No',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "6.	Whether records of VWSC meetings are available? ",
                                 options: [
                                   'Yes',
                                   'No',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "7.	VWSC/GP involved in O&M:  ",
                                 options: [
                                   'Yes – Active ',
                                   'Yes – Limited ',
                                   'No',
                                   'Not Applicable',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "8.	Scheme formally handed over to GP/VWSC:  ",
                                 options: [
                                   'Yes',
                                   'No',
                                   'Not Applicable',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "9.	Operation & Maintenance arrangements: ",
                                 options: [
                                   'VWSC ',
                                   'PHED ',
                                   'Outsourced Contractor ',
                                   'No arrangement',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "10.	Community awareness about scheme features: ",
                                 options: [
                                   'Well informed ',
                                   'Some awareness ',
                                   'No awareness',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
                                   });
                                 },
                               ),
                               CustomRadioQuestion(
                                 questionText: "11.	Community satisfaction with water quality:  ",
                                 options: [
                                   'Satisfied ',
                                   'Partially Satisfied ',
                                   'Dissatisfied ',
                                   'Not Interacted ',
                                 ], // You can pass more options if needed
                                 selectedValue: selectedValueQ1,
                                 onChanged: (val) {
                                   setState(() {
                                     selectedValueQ1 = val;
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
                                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CommunityFeedbackPartC()),);
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
                       ),
                     )
                   ],
                 ),
              ),
            ],
          ),
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
