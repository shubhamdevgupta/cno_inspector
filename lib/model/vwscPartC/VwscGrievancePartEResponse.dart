class VwscGrievance {
  final int userid;
  final int stateid;
  final int villageid;
  final int grievanceMechAvl;
  final int grievanceTurnAroundTime;
  final List<int> registrationType;

  /// New parameter to capture user observations for grievance redressal
  final String observationGrievanceRedressal;

  /// New parameter to store physical status (e.g., 1 - done, 0 - not done)
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
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      grievanceMechAvl: json['grievance_mech_avl'],
      grievanceTurnAroundTime: json['grievance_turn_around_time'],
      registrationType: List<int>.from(json['registration_type']),
      observationGrievanceRedressal: json['observation_grievance_redressal'], // <-- NEW
      phyStatus: json['phy_status'], // <-- NEW
    );
  }
}
