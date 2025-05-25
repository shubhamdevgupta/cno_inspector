class VwscGrievance {
  final int userid;
  final int stateid;
  final int villageid;
  final int grievanceMechAvl;
  final int grievanceTurnAroundTime;
  final List<int> registrationType;

  VwscGrievance({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.grievanceMechAvl,
    required this.grievanceTurnAroundTime,
    required this.registrationType,
  });

  factory VwscGrievance.fromJson(Map<String, dynamic> json) {
    return VwscGrievance(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      grievanceMechAvl: json['grievance_mech_avl'],
      grievanceTurnAroundTime: json['grievance_turn_around_time'],
      registrationType: List<int>.from(json['registration_type']),
    );
  }
}
