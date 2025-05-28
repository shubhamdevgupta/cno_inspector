class Tecnocommercialviabilityresponsebelow {
  final int userId;
  final int stateId;
  final int districtId;
  final String? annualOmCostScheme;
  final String? waterChargesStakeholders;
  final String? statePlanMeetingRemainingExpenses;
  final String? skilledManpowerRequiredOperations;
  final String? createdBy;
  final String? createdIp;
  final int phyStatus;

  Tecnocommercialviabilityresponsebelow({
    required this.userId,
    required this.stateId,
    required this.districtId,
    this.annualOmCostScheme,
    this.waterChargesStakeholders,
    this.statePlanMeetingRemainingExpenses,
    this.skilledManpowerRequiredOperations,
    this.createdBy,
    this.createdIp,
    required this.phyStatus,
  });

  factory Tecnocommercialviabilityresponsebelow.fromJson(Map<String, dynamic> json) {
    return Tecnocommercialviabilityresponsebelow(
      userId: json['userid'] ?? 0,
      stateId: json['stateid'] ?? 0,
      districtId: json['districtid'] ?? 0,
      annualOmCostScheme: json['What_annual_OM_cost_scheme'],
      waterChargesStakeholders: json['What_water_charges_stakeholders'],
      statePlanMeetingRemainingExpenses: json['What_State_plan_meeting_remaining_expenses'],
      skilledManpowerRequiredOperations: json['Expected_skilled_manpower_required_operations'],
      createdBy: json['createdby'],
      createdIp: json['createdip'],
      phyStatus: json['phy_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userId,
      'stateid': stateId,
      'districtid': districtId,
      'What_annual_OM_cost_scheme': annualOmCostScheme,
      'What_water_charges_stakeholders': waterChargesStakeholders,
      'What_State_plan_meeting_remaining_expenses': statePlanMeetingRemainingExpenses,
      'Expected_skilled_manpower_required_operations': skilledManpowerRequiredOperations,
      'createdby': createdBy,
      'createdip': createdIp,
      'phy_status': phyStatus,
    };
  }
}
