class QualityAssuranceCommissioning {
  final int userid;
  final int stateid;
  final int districtid;
  final int whoAuthorizedInspectMeasureFieldInspection;
  final int isCommissioningProtocolFollowed;
  final int duringCommissioningSchemesPresent;
  final int hasDistrictUndertakenAssessmentInspectionAgencies;
  final int modeType;
  final String observationQualityAssurance;

  QualityAssuranceCommissioning({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.whoAuthorizedInspectMeasureFieldInspection,
    required this.isCommissioningProtocolFollowed,
    required this.duringCommissioningSchemesPresent,
    required this.hasDistrictUndertakenAssessmentInspectionAgencies,
    required this.modeType,
    required this.observationQualityAssurance
  });

  factory QualityAssuranceCommissioning.fromJson(Map<String, dynamic> json) {
    return QualityAssuranceCommissioning(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      whoAuthorizedInspectMeasureFieldInspection:
      json['Who_authorized_inspect_measure_field_inspection'],
      isCommissioningProtocolFollowed: json['Is_commissioning_protocol_followed'],
      duringCommissioningSchemesPresent: json['During_commissioning_schemes_present'],
      hasDistrictUndertakenAssessmentInspectionAgencies:
      json['Has_district_undertaken_assessment_inspection_agencies'],
      modeType:json['phy_status'],
      observationQualityAssurance:json['Obseration_Quality_Assurance_Commissioning']
    );
  }
}
