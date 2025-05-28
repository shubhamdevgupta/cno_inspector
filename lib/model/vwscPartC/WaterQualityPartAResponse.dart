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
  final int isThereAnyPipedWaterSupplySchemeInTheVillage;
  final int whatIsTheTypeOfSchemePresentlyCommissioned;
  final String ifSchemeIsCommissionedHowManyHouseholdsAreBeingBenefitted;
  final int whatIsThePresentStatusOfWaterSupplySchemes;
  final int waterSupplyFrequencyAssuredToVillagersInTheScheme;
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
    required this.isThereAnyPipedWaterSupplySchemeInTheVillage,
    required this.whatIsTheTypeOfSchemePresentlyCommissioned,
    required this.ifSchemeIsCommissionedHowManyHouseholdsAreBeingBenefitted,
    required this.whatIsThePresentStatusOfWaterSupplySchemes,
    required this.waterSupplyFrequencyAssuredToVillagersInTheScheme,
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
      whetherPwsReachAllSchoolAnganwadiPhc: List<int>.from(json['whether_pws_reach_all_school_anganwadiphc']),

      // New fields
      phyStatus: json['phy_status'],
      isThereAnyPipedWaterSupplySchemeInTheVillage: json['Is_there_any_piped_water_supply_scheme_in_the_village'],
      whatIsTheTypeOfSchemePresentlyCommissioned: json['What_is_the_type_of_scheme_presently_commissioned'],
      ifSchemeIsCommissionedHowManyHouseholdsAreBeingBenefitted: json['If_scheme_is_commissioned_how_many_households_are_being_benefitted'],
      whatIsThePresentStatusOfWaterSupplySchemes: json['What_is_the_present_status_of_water_supply_schemes'],
      waterSupplyFrequencyAssuredToVillagersInTheScheme: json['Water_supply_frequency_assured_to_villagers_in_the_scheme'],
      remoteGroupsPlanned: json['rdb_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme'],
      remoteGroupsPlannedDetails: json['txt_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme'],
      observationWaterSupplyFunctionality: json['ObservationWatersupplyFunctionality'],
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
      'whether_pws_reach_all_school_anganwadiphc': whetherPwsReachAllSchoolAnganwadiPhc,

      // New fields
      'phy_status': phyStatus,
      'Is_there_any_piped_water_supply_scheme_in_the_village': isThereAnyPipedWaterSupplySchemeInTheVillage,
      'What_is_the_type_of_scheme_presently_commissioned': whatIsTheTypeOfSchemePresentlyCommissioned,
      'If_scheme_is_commissioned_how_many_households_are_being_benefitted': ifSchemeIsCommissionedHowManyHouseholdsAreBeingBenefitted,
      'What_is_the_present_status_of_water_supply_schemes': whatIsThePresentStatusOfWaterSupplySchemes,
      'Water_supply_frequency_assured_to_villagers_in_the_scheme': waterSupplyFrequencyAssuredToVillagersInTheScheme,
      'rdb_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme': remoteGroupsPlanned,
      'txt_Whether_remote_SC_ST_PVTG_groups_existing_in_command_area_of_the_scheme_has_been_planned_in_scheme': remoteGroupsPlannedDetails,
      'ObservationWatersupplyFunctionality': observationWaterSupplyFunctionality,
    };
  }
}
