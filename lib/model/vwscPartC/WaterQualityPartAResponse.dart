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
    );
  }
}
