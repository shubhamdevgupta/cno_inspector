class SourceSurveyResponse {
  final bool status;
  final String message;
  final List<SourceSurveyItem> result;

  SourceSurveyResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SourceSurveyResponse.fromJson(Map<String, dynamic> json) {
    return SourceSurveyResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List<dynamic>?)
          ?.map((e) => SourceSurveyItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class SourceSurveyItem {
  final int userid;
  final int stateid;
  final int schemeid;
  final int isRcmndShiftToSurfaceWtr;
  final int anyStudyAccessGwBeforeSw;
  final int noVillagesSafeZone;
  final int noVillagesCriticalZone;
  final int noVillagesSemiCriticalZone;
  final int incaseGwContAnyAnalysisConduct;
  final int wtrAllocationFrmStateWRDIDFrmSw;
  final dynamic createdby;
  final dynamic createdip;

  final String represe_of_ource_finding_committee;
  final String cost_effective_alternative_sources;
  final int phy_status;
  final String Remarks_Source;

  SourceSurveyItem({
    required this.userid,
    required this.stateid,
    required this.schemeid,
    required this.isRcmndShiftToSurfaceWtr,
    required this.anyStudyAccessGwBeforeSw,
    required this.noVillagesSafeZone,
    required this.noVillagesCriticalZone,
    required this.noVillagesSemiCriticalZone,
    required this.incaseGwContAnyAnalysisConduct,
    required this.wtrAllocationFrmStateWRDIDFrmSw,
    this.createdby,
    this.createdip,

    required this.represe_of_ource_finding_committee,
    required this.cost_effective_alternative_sources,
    required this.phy_status,
    required this.Remarks_Source,

  });
 /* "userid": 1726,
  "stateid": 17,
  "schemeid": 30080100,
  "is_rcmnd_shift_to_surface_wtr": 1,
  "any_study_access_gw_before_sw": 1,
  "no_villages_safe_zone": 10,
  "no_villages_critical_zone": 11,
  "no_villages_semi_critical_zone": 12,
  "incase_gw_cont_any_analysis_conduct": 1,
  "wtr_allocation_frm_state_WRD_ID_frm_sw": 1,
  "represent_of_source_finding_committee": "rer",
  "cost_effective_alternative_sources": "tes data q7",
  "phy_status": 0,
  "createdby": null,
  "createdip": null,
  "Remarks_Source": ""*/

  factory SourceSurveyItem.fromJson(Map<String, dynamic> json) {
    return SourceSurveyItem(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      schemeid: json['schemeid'] ?? 0,
      isRcmndShiftToSurfaceWtr: json['is_rcmnd_shift_to_surface_wtr'] ?? 0,
      anyStudyAccessGwBeforeSw: json['any_study_access_gw_before_sw'] ?? 0,
      noVillagesSafeZone: json['no_villages_safe_zone'] ?? 0,
      noVillagesCriticalZone: json['no_villages_critical_zone'] ?? 0,
      noVillagesSemiCriticalZone: json['no_villages_semi_critical_zone'] ?? 0,
      incaseGwContAnyAnalysisConduct: json['incase_gw_cont_any_analysis_conduct'] ?? 0,
      wtrAllocationFrmStateWRDIDFrmSw: json['wtr_allocation_frm_state_WRD_ID_frm_sw'] ?? 0,
      createdby: json['createdby'],
      createdip: json['createdip'],
/////////////
      represe_of_ource_finding_committee: json['represe_of_ource_finding_committee'] ?? "",
      cost_effective_alternative_sources: json['cost_effective_alternative_sources'] ?? "",
      phy_status: json['phy_status'] ?? 0,
      Remarks_Source: json['Remarks_Source'] ?? "",

    );
  }
}
