class OperationMaintenance {
  final int userid;
  final int stateid;
  final int districtid;
  final int isAProtocolHandingInVillageInfrastructurePlace;
  final double perOfVillagesWhereTrainedMultiSkilledManpowerAvailable;
  final int isWaterFeeChargedFromHouseholds;
  final int feeAmountPerMonth;
  final int isItUniformBasedOnConsumption;
  final double perOfVillagesWhereUserFeeCollected;

  OperationMaintenance({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.isAProtocolHandingInVillageInfrastructurePlace,
    required this.perOfVillagesWhereTrainedMultiSkilledManpowerAvailable,
    required this.isWaterFeeChargedFromHouseholds,
    required this.feeAmountPerMonth,
    required this.isItUniformBasedOnConsumption,
    required this.perOfVillagesWhereUserFeeCollected,
  });

  factory OperationMaintenance.fromJson(Map<String, dynamic> json) {
    return OperationMaintenance(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      isAProtocolHandingInVillageInfrastructurePlace:
      json['is_a_protocol_handing_in_village_infrastructure_place'],
      perOfVillagesWhereTrainedMultiSkilledManpowerAvailable:
      (json['Per_of_villages_where_trained_multi_skilled_manpower_available']).toDouble(),
      isWaterFeeChargedFromHouseholds:
      json['is_water_fee_charged_from_households'],
      feeAmountPerMonth: json['fee_amount_per_month'],
      isItUniformBasedOnConsumption: json['is_it_uniform_based_on_consumption'],
      perOfVillagesWhereUserFeeCollected:
      (json['per_of_villages_where_User_Fee_collected']).toDouble(),
    );
  }
}
