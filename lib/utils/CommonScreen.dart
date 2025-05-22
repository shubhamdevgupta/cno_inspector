import 'package:cno_inspection/views/InteractionVWSC/GrievancePartE.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/InteractionVWSC/CommunityFeedbackPartC.dart';
import '../views/InteractionVWSC/CommunityInvolvementPartB.dart';
import '../views/InteractionVWSC/WaterQualityPartD.dart';
import '../views/InteractionVWSC/WaterSupplyPartA.dart';
import 'Appcolor.dart';



class NewScreenPoints extends StatelessWidget {
  int no;


  NewScreenPoints({required this.no});

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
  var str = ['1', '2', '3', '4', '5'];

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
    for (int i = 1; i <= numberOfPoints; i++) {
      if (i == numberOfPoints)
        widgets.add(_buildPoint(context, i.toString(), true));
      else
        widgets.add(_buildPoint(context, i.toString(), false));

      if (i <= numberOfPoints - 1) {
        widgets.add(_buildLine());
      }
    }

    return widgets;
  }

  Widget _buildPoint(BuildContext context, String title, bool done) {
    return GestureDetector(
      onTap: () {
        if (title == "1") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => WaterSupplyPartA()),
          );
        }
        if (title == "2") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => CommunityInvolvementPartB()),
          );
        }
        if (title == "3") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => CommunityFeedbackPartC()),
          );
        }
        if (title == "4") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => WaterQualityPartD()),
          );
        }     if (title == "5") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => GrievancePartE()),
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

