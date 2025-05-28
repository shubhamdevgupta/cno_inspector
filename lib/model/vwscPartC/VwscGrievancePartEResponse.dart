class VwscGrievance {
  final int userid;
  final int stateid;
  final int villageid;
  final int grievanceMechAvl;
  final int grievanceTurnAroundTime;
  final List<int> registrationType;

  /// New parameter to capture user observations for grievance redressal.
  final String observationGrievanceRedressal;

  /// New parameter to store physical status (e.g., 1 - done, 0 - not done).
  final int phyStatus;



  VwscGrievance({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.grievanceMechAvl,
    required this.grievanceTurnAroundTime,
    required this.registrationType,
    required this.observationGrievanceRedressal, // <-- NEW
    required this.phyStatus, // <-- NEW

  });

  factory VwscGrievance.fromJson(Map<String, dynamic> json) {
    return VwscGrievance(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      villageid: json['villageid'] ?? 0,
      grievanceMechAvl: json['grievance_mech_avl'] ?? 0,
      grievanceTurnAroundTime: json['grievance_turn_around_time'] ?? 0,
      registrationType: List<int>.from(json['registration_type'] ?? []),
      observationGrievanceRedressal:
      json['ObservationGrievance_Redressal'] ?? "",
      phyStatus: json['phy_status'] ?? 0,

    );
  }

  /// Convert the object to JSON if needed.
  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'villageid': villageid,
      'grievance_mech_avl': grievanceMechAvl,
      'grievance_turn_around_time': grievanceTurnAroundTime,
      'registration_type': registrationType,
      'ObservationGrievance_Redressal': observationGrievanceRedressal,
      'phy_status': phyStatus,

    };
  }
}
