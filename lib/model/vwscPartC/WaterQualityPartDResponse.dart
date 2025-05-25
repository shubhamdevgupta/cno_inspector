class WaterQualityMonitoring {
  final int userid;
  final int stateid;
  final int villageid;
  final int isFtkAvl;
  final int ftkTestingPeriod;
  final int numberWomenTrainedFtk;
  final String whoTestFtk;
  final int isChlorinationDisinfectionDone;
  final int frcAvlAtEnd;

  WaterQualityMonitoring({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.isFtkAvl,
    required this.ftkTestingPeriod,
    required this.numberWomenTrainedFtk,
    required this.whoTestFtk,
    required this.isChlorinationDisinfectionDone,
    required this.frcAvlAtEnd,
  });

  factory WaterQualityMonitoring.fromJson(Map<String, dynamic> json) {
    return WaterQualityMonitoring(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      isFtkAvl: json['is_ftk_avl'],
      ftkTestingPeriod: json['ftk_testing_period'],
      numberWomenTrainedFtk: json['number_women_trained_ftk'],
      whoTestFtk: json['who_test_ftk'],
      isChlorinationDisinfectionDone: json['Is_chlorination_disinfection_done'],
      frcAvlAtEnd: json['frc_avl_at_end'],
    );
  }
}
