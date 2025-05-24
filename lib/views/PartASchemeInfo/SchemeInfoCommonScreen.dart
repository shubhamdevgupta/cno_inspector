
import 'package:cno_inspection/views/InteractionVWSC/CommunityFeedbackPartC.dart';
import 'package:cno_inspection/views/InteractionVWSC/CommunityInvolvementPartB.dart';
import 'package:cno_inspection/views/InteractionVWSC/GrievancePartE.dart';
import 'package:cno_inspection/views/InteractionVWSC/WaterQualityPartD.dart';
import 'package:cno_inspection/views/InteractionVWSC/WaterSupplyPartA.dart';
import 'package:cno_inspection/views/PArtASchemeInfo/PartASourceScreen.dart';
import 'package:cno_inspection/views/PArtASchemeInfo/PartBSchemePlanningScreen.dart';
import 'package:cno_inspection/views/PArtASchemeInfo/PartCRetrofittingAugmentationScreen.dart';
import 'package:cno_inspection/views/PArtASchemeInfo/PartDSchemeImplementationScreen.dart';
import 'package:cno_inspection/views/PArtASchemeInfo/PartEVisual%20Inspection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Appcolor.dart';



class Schemeinfocommonscreen extends StatelessWidget {
  int no;


  Schemeinfocommonscreen({required this.no});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScreenPoints(no: no),
        PointsAndLines(
          numberOfPoints: no,
        )
      ],
    );
  }
}

class ScreenPoints extends StatelessWidget {
  var no;


  ScreenPoints(
      {required this.no});

  final int numberOfPoints = 1;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: Text(
            buildText(),
            style: TextStyle(
              color: Appcolor.btncolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  String buildText() {
    String screen = "Screen:- ";
    return screen;
  }
}

class PointsAndLines extends StatelessWidget {
  int numberOfPoints = 4;
  var str = ['A', 'B', 'C', 'D', 'E', 'F'];

  PointsAndLines({
    required this.numberOfPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: _buildPointsAndLines(context),
      ),
    );
  }

  List<Widget> _buildPointsAndLines(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < numberOfPoints; i++) {
      String letter = String.fromCharCode(65 + i); // 65 is ASCII for 'A'
      bool isLast = (i == numberOfPoints - 1);
      widgets.add(_buildPoint(context, letter, isLast));

      if (!isLast) {
        widgets.add(_buildLine());
      }
    }
    return widgets;
  }


  Widget _buildPoint(BuildContext context, String title, bool done) {
    return GestureDetector(
      onTap: () {
        if (title == "A") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SourceScreenQuestions()),
          );
        }
        if (title == "B") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SchemePlanningScreen()),
          );
        }
        if (title == "C") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => RetrofittingAugmentationScreen()),
          );
        }
        if (title == "D") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SchemeImplementationScreen()),
          );
        }     if (title == "E") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => VisualInspectionScreen()),
          );
        }
        // Add more cases if needed
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done ? Appcolor.btncolor : Colors.grey,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLine() {
    return Container(
      width: 20,
      height: 2,
      color: Colors.black,
    );
  }
}

