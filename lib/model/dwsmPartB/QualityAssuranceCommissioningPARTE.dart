class QualityAssuranceResponse {
  final bool status;
  final String message;
  final List<QualityAssuranceResult> result;

  QualityAssuranceResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory QualityAssuranceResponse.fromJson(Map<String, dynamic> json) {
    return QualityAssuranceResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List)
          .map((item) => QualityAssuranceResult.fromJson(item))
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

class QualityAssuranceResult {
  final int userid;
  final int stateid;
  final int districtid;
  final String whoAuthorizedInspectIds;
  final List<int> whoAuthorizedInspect;
  final int isCommissioningProtocolFollowed;
  final String duringCommissioningPresentIds;
  final List<int> duringCommissioningPresent;
  final int hasDistrictUndertakenAssessment;
  final dynamic createdBy;
  final dynamic createdIp;
  final int hasDistrictHiredThirdParty;
  final int phyStatus;
  final String observation;

  QualityAssuranceResult({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.whoAuthorizedInspectIds,
    required this.whoAuthorizedInspect,
    required this.isCommissioningProtocolFollowed,
    required this.duringCommissioningPresentIds,
    required this.duringCommissioningPresent,
    required this.hasDistrictUndertakenAssessment,
    this.createdBy,
    this.createdIp,
    required this.hasDistrictHiredThirdParty,
    required this.phyStatus,
    required this.observation,
  });

  factory QualityAssuranceResult.fromJson(Map<String, dynamic> json) {
    return QualityAssuranceResult(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      districtid: json['districtid'] ?? 0,
      whoAuthorizedInspectIds:
      json['Who_authorized_inspect_measure_works_field_inspectionIds'] ?? '',
      whoAuthorizedInspect: List<int>.from(
          json['Who_authorized_inspect_measure_works_field_inspection'] ?? []),
      isCommissioningProtocolFollowed:
      json['Is_commissioning_protocol_followed'] ?? 0,
      duringCommissioningPresentIds:
      json['During_commissioning_schemes_generally_presentIds'] ?? '',
      duringCommissioningPresent: List<int>.from(
          json['During_commissioning_schemes_generally_present'] ?? []),
      hasDistrictUndertakenAssessment:
      json['Has_district_undertaken_assessment_inspection_agencies'] ?? 0,
      createdBy: json['createdby'],
      createdIp: json['createdip'],
      hasDistrictHiredThirdParty:
      json['Has_distric_hired_third_party_inspection_agencies_JJM_schemes'] ??
          0,
      phyStatus: json['phy_status'] ?? 0,
      observation: json['Obseration_Quality_Assurance_Commissioning'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'districtid': districtid,
      'Who_authorized_inspect_measure_works_field_inspectionIds':
      whoAuthorizedInspectIds,
      'Who_authorized_inspect_measure_works_field_inspection':
      whoAuthorizedInspect,
      'Is_commissioning_protocol_followed': isCommissioningProtocolFollowed,
      'During_commissioning_schemes_generally_presentIds':
      duringCommissioningPresentIds,
      'During_commissioning_schemes_generally_present':
      duringCommissioningPresent,
      'Has_district_undertaken_assessment_inspection_agencies':
      hasDistrictUndertakenAssessment,
      'createdby': createdBy,
      'createdip': createdIp,
      'Has_distric_hired_third_party_inspection_agencies_JJM_schemes':
      hasDistrictHiredThirdParty,
      'phy_status': phyStatus,
      'Obseration_Quality_Assurance_Commissioning': observation,
    };
  }
}
