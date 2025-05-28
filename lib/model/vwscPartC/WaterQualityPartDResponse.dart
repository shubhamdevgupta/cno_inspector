/// Model class representing water quality monitoring data.
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

  /// New parameter to capture user’s observation or remarks.
  final String observationWaterQualityMonitoring;


  /// New parameter for physical status.
  final int phyStatus;

  /// Constructor to initialize the class.
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
    required this.observationWaterQualityMonitoring, // <-- New parameter

    required this.phyStatus, // <-- New parameter
  });

  /// Factory method to create an instance from JSON.
  factory WaterQualityMonitoring.fromJson(Map<String, dynamic> json) {
    return WaterQualityMonitoring(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      villageid: json['villageid'] ?? 0,
      isFtkAvl: json['is_ftk_avl'] ?? 0,
      ftkTestingPeriod: json['ftk_testing_period'] ?? 0,
      numberWomenTrainedFtk: json['number_women_trained_ftk'] ?? 0,
      whoTestFtk: json['who_test_ftk'] ?? '',
      isChlorinationDisinfectionDone:
      json['Is_chlorination_disinfection_done'] ?? 0,
      frcAvlAtEnd: json['frc_avl_at_end'] ?? 0,
      observationWaterQualityMonitoring:
      json['ObservationWater_Quality_Monitoring'] ?? "",

      phyStatus: json['phy_status'] ?? 0,
    );
  }

  /// Convert the object to JSON for API or database storage.
  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'villageid': villageid,
      'is_ftk_avl': isFtkAvl,
      'ftk_testing_period': ftkTestingPeriod,
      'number_women_trained_ftk': numberWomenTrainedFtk,
      'who_test_ftk': whoTestFtk,
      'Is_chlorination_disinfection_done': isChlorinationDisinfectionDone,
      'frc_avl_at_end': frcAvlAtEnd,
      'ObservationWater_Quality_Monitoring':
      observationWaterQualityMonitoring,

      'phy_status': phyStatus,
    };
  }
}
