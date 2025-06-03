class MonitoringQualityLabResponse {
  final bool status;
  final String message;
  final List<MonitoringQualityLabResult> result;

  MonitoringQualityLabResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory MonitoringQualityLabResponse.fromJson(Map<String, dynamic> json) {
    return MonitoringQualityLabResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List)
          .map((e) => MonitoringQualityLabResult.fromJson(e))
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

class MonitoringQualityLabResult {
  final int userid;
  final int stateid;
  final int districtid;
  final int areWaterSupplyAssetsGeotagged;
  final int doesDistrictNablAccreditedLab;
  final String doesDistrictNablAccreditedLabDesc;
  final String? ifNoHowIsTestingManagedDescription;
  final String observationMonitoringQualityLabInfrastructure;
  final dynamic createdby;
  final dynamic createdip;
  final int phyStatus;

  MonitoringQualityLabResult({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.areWaterSupplyAssetsGeotagged,
    required this.doesDistrictNablAccreditedLab,
    required this.doesDistrictNablAccreditedLabDesc,
    required this.ifNoHowIsTestingManagedDescription,
    required this.observationMonitoringQualityLabInfrastructure,
    this.createdby,
    this.createdip,
    required this.phyStatus,
  });

  factory MonitoringQualityLabResult.fromJson(Map<String, dynamic> json) {
    return MonitoringQualityLabResult(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      districtid: json['districtid'] ?? 0,
      areWaterSupplyAssetsGeotagged:
      json['Are_water_supply_assets_geotagged'] ?? 0,
      doesDistrictNablAccreditedLab:
      json['Does_district_NABL_accredited_lab'] ?? 0,
      doesDistrictNablAccreditedLabDesc:
      json['Does_district_NABL_accredited_lab_desc'] ?? '',
      ifNoHowIsTestingManagedDescription:
      json['if_no_how_is_testing_managed_description'],
      observationMonitoringQualityLabInfrastructure:
      json['Obseration_Monitoring_Quality_lab_Infrastructure'] ?? '',
      createdby: json['createdby'],
      createdip: json['createdip'],
      phyStatus: json['phy_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'districtid': districtid,
      'Are_water_supply_assets_geotagged': areWaterSupplyAssetsGeotagged,
      'Does_district_NABL_accredited_lab': doesDistrictNablAccreditedLab,
      'Does_district_NABL_accredited_lab_desc':
      doesDistrictNablAccreditedLabDesc,
      'if_no_how_is_testing_managed_description':
      ifNoHowIsTestingManagedDescription,
      'Obseration_Monitoring_Quality_lab_Infrastructure':
      observationMonitoringQualityLabInfrastructure,
      'createdby': createdby,
      'createdip': createdip,
      'phy_status': phyStatus,
    };
  }
}
