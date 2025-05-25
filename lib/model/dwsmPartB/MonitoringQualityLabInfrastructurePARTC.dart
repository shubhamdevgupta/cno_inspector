class MonitoringQualityLabInfrastructure {
  final int userid;
  final int stateid;
  final int districtid;
  final int areWaterSupplyAssetsGeotagged;
  final int doesDistrictHaveNablAccreditedLabEquivalent;
  final String ifNoHowIsTestingManagedDescription;

  MonitoringQualityLabInfrastructure({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.areWaterSupplyAssetsGeotagged,
    required this.doesDistrictHaveNablAccreditedLabEquivalent,
    required this.ifNoHowIsTestingManagedDescription,
  });

  factory MonitoringQualityLabInfrastructure.fromJson(
      Map<String, dynamic> json) {
    return MonitoringQualityLabInfrastructure(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      areWaterSupplyAssetsGeotagged: json['are_water_supply_assets_geotagged'],
      doesDistrictHaveNablAccreditedLabEquivalent:
      json['does_the_district_have_an_nabl_accredited_lab_equivalent'],
      ifNoHowIsTestingManagedDescription:
      json['if_no_how_is_testing_managed_description'],
    );
  }
}
