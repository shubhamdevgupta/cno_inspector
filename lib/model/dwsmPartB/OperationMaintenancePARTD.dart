class OperationMaintenance {
  final int userid;
  final int stateid;
  final int districtid;
  final int isAProtocolHandingInVillageInfrastructurePlace;
  final double perOfVillagesWhereTrainedMultiSkilledManpowerAvailable;
  final int isWaterFeeChargedFromHouseholds;
  final int isItUniformBasedOnConsumption;
  final double perOfVillagesWhereUserFeeCollected;
  final int modeType;
  final String obserVationOperationMaintenance;

  OperationMaintenance({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.isAProtocolHandingInVillageInfrastructurePlace,
    required this.perOfVillagesWhereTrainedMultiSkilledManpowerAvailable,
    required this.isWaterFeeChargedFromHouseholds,
    required this.isItUniformBasedOnConsumption,
    required this.perOfVillagesWhereUserFeeCollected,
    required this.modeType,
    required this.obserVationOperationMaintenance
  });

  factory OperationMaintenance.fromJson(Map<String, dynamic> json) {
    return OperationMaintenance(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      isAProtocolHandingInVillageInfrastructurePlace:
      json['Is_protocol_in_village_infrastructure'],
      perOfVillagesWhereTrainedMultiSkilledManpowerAvailable:
      (json['Percentage_villages_trained_manpower']).toDouble(),
      isWaterFeeChargedFromHouseholds:
      json['Is_Water_charged_households_fee_amount'],
      isItUniformBasedOnConsumption: json['Is_Water_charged_households_uniform_consumption'],
      perOfVillagesWhereUserFeeCollected:
      (json['Percentage_villages_User_Fee_collected']).toDouble(),
      modeType:json['phy_status'],
      obserVationOperationMaintenance:json['Obseration_Operation_Maintenance']
    );
  }
}
