class PublicComplaintsGrievanceRedressal {
  final int userid;
  final int stateid;
  final int districtid;
  final int grievanceRedressalMechanismAvailable;
  final List<int> howGrievancesRegisteredVillagers;
  final int areComplaintsReceivedPublicRegardingSchemes;
  final int yesTypeComplaints;
  final String yesTypeComplaintsOthers;
  final int yesTypeComplaintsOthersAverageTimeResolution;
  final String yesTypeComplaintsOthersActionTakenDepartment;

  PublicComplaintsGrievanceRedressal({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.grievanceRedressalMechanismAvailable,
    required this.howGrievancesRegisteredVillagers,
    required this.areComplaintsReceivedPublicRegardingSchemes,
    required this.yesTypeComplaints,
    required this.yesTypeComplaintsOthers,
    required this.yesTypeComplaintsOthersAverageTimeResolution,
    required this.yesTypeComplaintsOthersActionTakenDepartment,
  });

  factory PublicComplaintsGrievanceRedressal.fromJson(
      Map<String, dynamic> json) {
    return PublicComplaintsGrievanceRedressal(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      grievanceRedressalMechanismAvailable:
      json['Grievance_Redressal_mechanism_available'],
      howGrievancesRegisteredVillagers:
      json['How_grievances_registered_villagers'],
      areComplaintsReceivedPublicRegardingSchemes:
      json['Are_complaints_received_public_regarding_schemes'],
      yesTypeComplaints: json['yes_type_complaints'],
      yesTypeComplaintsOthers: json['yes_type_complaints_others'],
      yesTypeComplaintsOthersAverageTimeResolution:
      json['yes_type_complaints_others_What_average_time_resolution'],
      yesTypeComplaintsOthersActionTakenDepartment:
      json['yes_type_complaints_others_Action_taken_department'],
    );
  }
}
