class WaterSupplyFunctionality {
  final int userid;
  final int stateid;
  final int villageid;
  final int waterSupplyFrequency;
  final int isAdequateWaterQuantityReachToHh;
  final int isAdequateWaterQuantityReachToRemote;
  final String isAdequateWaterQuantityReachToRemoteReason;
  final int whetherWaterReachToTailEnd;
  final int schemeOperationalStatusCommissioning;
  final List<int> whetherPwsReachAllSchoolAnganwadiPhc;

  // New fields
  final int phyStatus;
  final int isPipedWaterSupplyScheme;
  final int typeOfSchemeCommissioned;
  final String schemeBeneficiaryHouseholds;
  final int presentStatusOfWaterSupplySchemes;
  final int waterSupplyFrequencyAssured;
  final int remoteGroupsPlanned;
  final String remoteGroupsPlannedDetails;
  final String observationWaterSupplyFunctionality;

  WaterSupplyFunctionality({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.waterSupplyFrequency,
    required this.isAdequateWaterQuantityReachToHh,
    required this.isAdequateWaterQuantityReachToRemote,
    required this.isAdequateWaterQuantityReachToRemoteReason,
    required this.whetherWaterReachToTailEnd,
    required this.schemeOperationalStatusCommissioning,
    required this.whetherPwsReachAllSchoolAnganwadiPhc,

    // New fields
    required this.phyStatus,
    required this.isPipedWaterSupplyScheme,
    required this.typeOfSchemeCommissioned,
    required this.schemeBeneficiaryHouseholds,
    required this.presentStatusOfWaterSupplySchemes,
    required this.waterSupplyFrequencyAssured,
    required this.remoteGroupsPlanned,
    required this.remoteGroupsPlannedDetails,
    required this.observationWaterSupplyFunctionality,
  });

  factory WaterSupplyFunctionality.fromJson(Map<String, dynamic> json) {
    return WaterSupplyFunctionality(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      waterSupplyFrequency: json['water_supply_frequency'],
      isAdequateWaterQuantityReachToHh: json['is_adequate_water_quantity_reach_to_hh'],
      isAdequateWaterQuantityReachToRemote: json['is_adequate_water_quantity_reach_to_remote'],
      isAdequateWaterQuantityReachToRemoteReason: json['is_adequate_water_quantity_reach_to_remote_reason'],
      whetherWaterReachToTailEnd: json['whether_water_reach_to_tail_end'],
      schemeOperationalStatusCommissioning: json['scheme_operational_status_commissioning'],
      whetherPwsReachAllSchoolAnganwadiPhc: List<int>.from(json['whether_pws_reach_all_school_anganwadi_phc']),

      // New fields
      phyStatus: json['phy_status'],
      isPipedWaterSupplyScheme: json['is_piped_water_supply_scheme'],
      typeOfSchemeCommissioned: json['type_of_scheme_commissioned'],
      schemeBeneficiaryHouseholds: json['scheme_beneficiary_households'],
      presentStatusOfWaterSupplySchemes: json['present_status_of_water_supply_schemes'],
      waterSupplyFrequencyAssured: json['water_supply_frequency_assured'],
      remoteGroupsPlanned: json['remote_groups_planned'],
      remoteGroupsPlannedDetails: json['remote_groups_planned_details'],
      observationWaterSupplyFunctionality: json['observation_water_supply_functionality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'villageid': villageid,
      'water_supply_frequency': waterSupplyFrequency,
      'is_adequate_water_quantity_reach_to_hh': isAdequateWaterQuantityReachToHh,
      'is_adequate_water_quantity_reach_to_remote': isAdequateWaterQuantityReachToRemote,
      'is_adequate_water_quantity_reach_to_remote_reason': isAdequateWaterQuantityReachToRemoteReason,
      'whether_water_reach_to_tail_end': whetherWaterReachToTailEnd,
      'scheme_operational_status_commissioning': schemeOperationalStatusCommissioning,
      'whether_pws_reach_all_school_anganwadi_phc': whetherPwsReachAllSchoolAnganwadiPhc,

      // New fields
      'phy_status': phyStatus,
      'is_piped_water_supply_scheme': isPipedWaterSupplyScheme,
      'type_of_scheme_commissioned': typeOfSchemeCommissioned,
      'scheme_beneficiary_households': schemeBeneficiaryHouseholds,
      'present_status_of_water_supply_schemes': presentStatusOfWaterSupplySchemes,
      'water_supply_frequency_assured': waterSupplyFrequencyAssured,
      'remote_groups_planned': remoteGroupsPlanned,
      'remote_groups_planned_details': remoteGroupsPlannedDetails,
      'observation_water_supply_functionality': observationWaterSupplyFunctionality,
    };
  }
}
