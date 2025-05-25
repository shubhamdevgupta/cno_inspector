class SchemePlanningResponse {
  final bool status;
  final String message;
  final List<SchemePlanningItem> result;

  SchemePlanningResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory SchemePlanningResponse.fromJson(Map<String, dynamic> json) {
    return SchemePlanningResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List<dynamic>?)
          ?.map((e) => SchemePlanningItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class SchemePlanningItem {
  final int userid;
  final int stateid;
  final int schemeid;
  final int isTopographicalSurvey;
  final int isGpsPhysicalSurvey;
  final int isGoogleEarthSurvey;
  final int noSurvey;
  final int runningHrsDesignTransmissionMain;
  final int retentionTimeOSHR;
  final int retentionTimeMBR;
  final String distributionNetwrkTerrianTypeRockyStrata;
  final String distributionNetwrkTerrianTypeSoilStrata;
  final int foundAsPerDPR;
  final String divationIfAny;
  final dynamic createdby;
  final dynamic createdip;

  SchemePlanningItem({
    required this.userid,
    required this.stateid,
    required this.schemeid,
    required this.isTopographicalSurvey,
    required this.isGpsPhysicalSurvey,
    required this.isGoogleEarthSurvey,
    required this.noSurvey,
    required this.runningHrsDesignTransmissionMain,
    required this.retentionTimeOSHR,
    required this.retentionTimeMBR,
    required this.distributionNetwrkTerrianTypeRockyStrata,
    required this.distributionNetwrkTerrianTypeSoilStrata,
    required this.foundAsPerDPR,
    required this.divationIfAny,
    this.createdby,
    this.createdip,
  });

  factory SchemePlanningItem.fromJson(Map<String, dynamic> json) {
    return SchemePlanningItem(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      schemeid: json['schemeid'] ?? 0,
      isTopographicalSurvey: json['is_topographical_survey'] ?? 0,
      isGpsPhysicalSurvey: json['is_gps_physical_survey'] ?? 0,
      isGoogleEarthSurvey: json['is_google_earth_survey'] ?? 0,
      noSurvey: json['no_survey'] ?? 0,
      runningHrsDesignTransmissionMain: json['running_hrs_per_day_design_transmission_main'] ?? 0,
      retentionTimeOSHR: json['retention_time_in_hrs_per_day_OSHR_OHT'] ?? 0,
      retentionTimeMBR: json['retention_time_in_hrs_per_day_mbr'] ?? 0,
      distributionNetwrkTerrianTypeRockyStrata: json['distribution_netwrk_terrian_type_rocky_strata'] ?? '',
      distributionNetwrkTerrianTypeSoilStrata: json['distribution_netwrk_terrian_type_soil_strata'] ?? '',
      foundAsPerDPR: json['found_as_per_dpr'] ?? 0,
      divationIfAny: json['divation_if_any'] ?? '',
      createdby: json['createdby'],
      createdip: json['createdip'],
    );
  }
}
