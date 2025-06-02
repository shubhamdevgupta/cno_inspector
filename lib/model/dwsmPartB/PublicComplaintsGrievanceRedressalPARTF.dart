class GrievanceResponse {
  final bool status;
  final String message;
  final List<GrievanceResult> result;

  GrievanceResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory GrievanceResponse.fromJson(Map<String, dynamic> json) {
    return GrievanceResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List)
          .map((item) => GrievanceResult.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Status': status,
      'Message': message,
      'Result': result.map((e) => e.toJson()).toList(),
    };
  }
}

class GrievanceResult {
  final int userid;
  final int stateid;
  final int districtid;
  final int grievanceRedressalMechanismAvailable;
  final String howGrievancesRegisteredVillagersIds;
  final dynamic howGrievancesRegisteredVillagers;
  final int areComplaintsReceived;
  final List<int> yesTypeComplaint;
  final String yesTypeComplaintIds;
  final String yesTypeComplaintsOthers;
  final String yesTypeComplaintsOthersAvgTimeResolution;
  final String yesTypeComplaintsOthersActionTaken;
  final dynamic createdBy;
  final dynamic createdIp;
  final int phyStatus;

  GrievanceResult({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.grievanceRedressalMechanismAvailable,
    required this.howGrievancesRegisteredVillagersIds,
    this.howGrievancesRegisteredVillagers,
    required this.areComplaintsReceived,
    required this.yesTypeComplaint,
    required this.yesTypeComplaintIds,
    required this.yesTypeComplaintsOthers,
    required this.yesTypeComplaintsOthersAvgTimeResolution,
    required this.yesTypeComplaintsOthersActionTaken,
    this.createdBy,
    this.createdIp,
    required this.phyStatus,
  });

  factory GrievanceResult.fromJson(Map<String, dynamic> json) {
    return GrievanceResult(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      districtid: json['districtid'] ?? 0,
      grievanceRedressalMechanismAvailable:
      json['Grievance_Redressal_mechanism_available'] ?? 0,
      howGrievancesRegisteredVillagersIds:
      json['How_grievances_registered_the_villagersIds'] ?? '',
      howGrievancesRegisteredVillagers:
      json['How_grievances_registered_the_villagers'],
      areComplaintsReceived:
      json['Are_complaints_received_public_regarding_schemes'] ?? 0,
      yesTypeComplaint: List<int>.from(json['yes_type_complaint'] ?? []),
      yesTypeComplaintIds: json['yes_type_complaintIds'] ?? '',
      yesTypeComplaintsOthers: json['yes_type_complaints_others'] ?? '',
      yesTypeComplaintsOthersAvgTimeResolution:
      json['yes_type_complaints_others_What_average_time_resolution'] ?? '',
      yesTypeComplaintsOthersActionTaken:
      json['yes_type_complaints_others_Action_taken_department'] ?? '',
      createdBy: json['createdby'],
      createdIp: json['createdip'],
      phyStatus: json['phy_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'districtid': districtid,
      'Grievance_Redressal_mechanism_available':
      grievanceRedressalMechanismAvailable,
      'How_grievances_registered_the_villagersIds':
      howGrievancesRegisteredVillagersIds,
      'How_grievances_registered_the_villagers':
      howGrievancesRegisteredVillagers,
      'Are_complaints_received_public_regarding_schemes':
      areComplaintsReceived,
      'yes_type_complaint': yesTypeComplaint,
      'yes_type_complaintIds': yesTypeComplaintIds,
      'yes_type_complaints_others': yesTypeComplaintsOthers,
      'yes_type_complaints_others_What_average_time_resolution':
      yesTypeComplaintsOthersAvgTimeResolution,
      'yes_type_complaints_others_Action_taken_department':
      yesTypeComplaintsOthersActionTaken,
      'createdby': createdBy,
      'createdip': createdIp,
      'phy_status': phyStatus,
    };
  }
}
