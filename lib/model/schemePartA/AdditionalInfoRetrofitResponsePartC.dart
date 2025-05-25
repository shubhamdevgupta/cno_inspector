class AdditionalInfoRetrofitResponse {
  final bool status;
  final String message;
  final List<AdditionalInfoRetrofitItem> result;

  AdditionalInfoRetrofitResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory AdditionalInfoRetrofitResponse.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoRetrofitResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List<dynamic>?)
          ?.map((e) => AdditionalInfoRetrofitItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class AdditionalInfoRetrofitItem {
  final int userid;
  final int stateid;
  final int schemeid;
  final int whetherAssesmentLegacyDone;
  final String ifYesWhetherAssesmentLegacyDoneMethod;
  final String ifNoWhetherAssesmentLegacyReason;
  final double legacyInfrastructureTransmissionPipelineKms;
  final double legacyInfrastructureDistributionPipelineKms;
  final double legacyInfrastructureWtpCapacityMld;
  final int legacyInfrastructureStorageStrNos;
  final double legacyInfrastructureStorageStrCapacityKl;
  final int buildDrawingInfrAvailable;
  final int ifYesIsItOnPMGati;
  final String ifNoReason;
  final dynamic createdby;
  final dynamic createdip;

  AdditionalInfoRetrofitItem({
    required this.userid,
    required this.stateid,
    required this.schemeid,
    required this.whetherAssesmentLegacyDone,
    required this.ifYesWhetherAssesmentLegacyDoneMethod,
    required this.ifNoWhetherAssesmentLegacyReason,
    required this.legacyInfrastructureTransmissionPipelineKms,
    required this.legacyInfrastructureDistributionPipelineKms,
    required this.legacyInfrastructureWtpCapacityMld,
    required this.legacyInfrastructureStorageStrNos,
    required this.legacyInfrastructureStorageStrCapacityKl,
    required this.buildDrawingInfrAvailable,
    required this.ifYesIsItOnPMGati,
    required this.ifNoReason,
    this.createdby,
    this.createdip,
  });

  factory AdditionalInfoRetrofitItem.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoRetrofitItem(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      schemeid: json['schemeid'] ?? 0,
      whetherAssesmentLegacyDone: json['whether_assesment_legacy_done'] ?? 0,
      ifYesWhetherAssesmentLegacyDoneMethod: json['if_yes_whether_assesment_legacy_done_method'] ?? '',
      ifNoWhetherAssesmentLegacyReason: json['if_no_whether_assesment_legacy_reason'] ?? '',
      legacyInfrastructureTransmissionPipelineKms: (json['legacy_infrastructure_tramission_pipeline_in_kms'] ?? 0).toDouble(),
      legacyInfrastructureDistributionPipelineKms: (json['legacy_infrastructure_distribution_pipeline_in_kms'] ?? 0).toDouble(),
      legacyInfrastructureWtpCapacityMld: (json['legacy_infrastructure_wtp_capcity_in_mld'] ?? 0).toDouble(),
      legacyInfrastructureStorageStrNos: json['legacy_infrastructure_storage_str_nos'] ?? 0,
      legacyInfrastructureStorageStrCapacityKl: (json['legacy_infrastructure_storage_str_capacity_kl'] ?? 0).toDouble(),
      buildDrawingInfrAvailable: json['build_drawing_infr_available'] ?? 0,
      ifYesIsItOnPMGati: json['if_yes_is_it_on_PMGati'] ?? 0,
      ifNoReason: json['if_no_reason'] ?? '',
      createdby: json['createdby'],
      createdip: json['createdip'],
    );
  }
}
