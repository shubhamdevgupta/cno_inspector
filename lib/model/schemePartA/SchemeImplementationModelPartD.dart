class SchemeImplementationModel {
  final int userid;
  final int stateid;
  final int schemeid;
  final int costOverrun;
  final int hasSchemeCostRevisedBeforeWork;
  final int schemeCostRevisedBeforeWorkYesPer;
  final String slsscDateForRevisedEstimate;
  final int numIntakeTubeWell;
  final double costIntakeTubeWellCr;
  final int numElectroMechanicalInclPump;
  final double costElectroMechanicalInclPumpCr;
  final int numWtp;
  final double costWtpCr;
  final int numMbr;
  final double costMbrCr;
  final int numTransmissionPipeline;
  final double costTransmissionPipelineCr;
  final int numDistributionPipeline;
  final double costDistributionPipelineCr;
  final int numDisinfectionUnit;
  final double costDisinfectionUnitCr;
  final int numOshrEsrOhtGsr;
  final double costOshrEsrOhtGsrCr;
  final int numIoTScada;
  final double costIoTScadaCr;
  final int numRoadRestoration;
  final double costRoadRestorationCr;
  final int numSolarComponents;
  final double costSolarComponentsCr;
  final int numOtherDgSetHhStorageTanksEtc;
  final double costOtherDgSetHhStorageTanksEtcCr;
  final int isComponentPlannedWtp;
  final int isComponentPlannedOshrEsrOhtGsr;
  final int isComponentPlannedSource;
  final int isComponentPlannedPipeline;
  final List<int> delayWorkReason;
  final List<int> costOverrunReason;
  final List<int> costRevisionReason;

  // New fields
  final double txtcost_levelzed_cost_cr;
  final int is_tpia_engaged_value;
  final int concurrent_supervission_scope_value;
  final String txtpws_status_under_scheme;
  final int phy_status;
  final String scheme_implementation_Remarks;
  final String Resion_for_delay_after_aword_other;
  final String Reason_for_revision;
  final String Reason_for_cost_overrun;

  SchemeImplementationModel({
    required this.userid,
    required this.stateid,
    required this.schemeid,
    required this.costOverrun,
    required this.hasSchemeCostRevisedBeforeWork,
    required this.schemeCostRevisedBeforeWorkYesPer,
    required this.slsscDateForRevisedEstimate,
    required this.numIntakeTubeWell,
    required this.costIntakeTubeWellCr,
    required this.numElectroMechanicalInclPump,
    required this.costElectroMechanicalInclPumpCr,
    required this.numWtp,
    required this.costWtpCr,
    required this.numMbr,
    required this.costMbrCr,
    required this.numTransmissionPipeline,
    required this.costTransmissionPipelineCr,
    required this.numDistributionPipeline,
    required this.costDistributionPipelineCr,
    required this.numDisinfectionUnit,
    required this.costDisinfectionUnitCr,
    required this.numOshrEsrOhtGsr,
    required this.costOshrEsrOhtGsrCr,
    required this.numIoTScada,
    required this.costIoTScadaCr,
    required this.numRoadRestoration,
    required this.costRoadRestorationCr,
    required this.numSolarComponents,
    required this.costSolarComponentsCr,
    required this.numOtherDgSetHhStorageTanksEtc,
    required this.costOtherDgSetHhStorageTanksEtcCr,
    required this.isComponentPlannedWtp,
    required this.isComponentPlannedOshrEsrOhtGsr,
    required this.isComponentPlannedSource,
    required this.isComponentPlannedPipeline,
    required this.delayWorkReason,
    required this.costOverrunReason,
    required this.costRevisionReason,

    // New fields
    required this.txtcost_levelzed_cost_cr,
    required this.is_tpia_engaged_value,
    required this.concurrent_supervission_scope_value,
    required this.txtpws_status_under_scheme,
    required this.phy_status,
    required this.scheme_implementation_Remarks,
    required this.Resion_for_delay_after_aword_other,
    required this.Reason_for_revision,
    required this.Reason_for_cost_overrun,
  });

  factory SchemeImplementationModel.fromJson(Map<String, dynamic> json) {
    return SchemeImplementationModel(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      schemeid: json['schemeid'] ?? 0,
      costOverrun: json['cost_overrun'] ?? 0,
      hasSchemeCostRevisedBeforeWork: json['has_scheme_cost_revised_befor_work'] ?? 0,
      schemeCostRevisedBeforeWorkYesPer: json['scheme_cost_revised_befor_work_yes_per'] ?? 0,
      slsscDateForRevisedEstimate: json['slssc_date_for_revised_estimate'] ?? '',
      numIntakeTubeWell: json['num_intake_tube_well'] ?? 0,
      costIntakeTubeWellCr: (json['cost_intake_tube_well_cr'] ?? 0).toDouble(),
      numElectroMechanicalInclPump: json['num_electro_mechanical_incl_pump'] ?? 0,
      costElectroMechanicalInclPumpCr: (json['cost_electro_mechanical_incl_pump_cr'] ?? 0).toDouble(),
      numWtp: json['num_wtp'] ?? 0,
      costWtpCr: (json['cost_wtp_cr'] ?? 0).toDouble(),
      numMbr: json['num_mbr'] ?? 0,
      costMbrCr: (json['cost_mbr'] ?? 0).toDouble(),
      numTransmissionPipeline: json['num_transmission_pipeline'] ?? 0,
      costTransmissionPipelineCr: (json['cost_transmission_pipeline_cr'] ?? 0).toDouble(),
      numDistributionPipeline: json['num_distribution_pipeline'] ?? 0,
      costDistributionPipelineCr: (json['cost_distribution_pipeline_cr'] ?? 0).toDouble(),
      numDisinfectionUnit: json['num_disinfection_unit'] ?? 0,
      costDisinfectionUnitCr: (json['cost_disinfection_unit_cr'] ?? 0).toDouble(),
      numOshrEsrOhtGsr: json['num_oshr_esr_oht_gsr'] ?? 0,
      costOshrEsrOhtGsrCr: (json['cost_oshr_esr_oht_gsr_cr'] ?? 0).toDouble(),
      numIoTScada: json['num_IoT_SCADA'] ?? 0,
      costIoTScadaCr: (json['cost_IoT_SCADA_cr'] ?? 0).toDouble(),
      numRoadRestoration: json['num_road_restoration'] ?? 0,
      costRoadRestorationCr: (json['cost_road_restoration_cr'] ?? 0).toDouble(),
      numSolarComponents: json['num_solar_components'] ?? 0,
      costSolarComponentsCr: (json['cost_solar_components_cr'] ?? 0).toDouble(),
      numOtherDgSetHhStorageTanksEtc: json['num_other_dg_set_hh_storage_tanks_etc'] ?? 0,
      costOtherDgSetHhStorageTanksEtcCr: (json['cost_other_dg_set_hh_storage_tanks_etc_cr'] ?? 0).toDouble(),
      isComponentPlannedWtp: json['is_compoent_planed_PT_gati_shakti_WTP'] ?? 0,
      isComponentPlannedOshrEsrOhtGsr: json['is_compoent_planed_PT_gati_shakti_oshr_esr_oht_gsr'] ?? 0,
      isComponentPlannedSource: json['is_compoent_planed_PT_gati_shakti_source'] ?? 0,
      isComponentPlannedPipeline: json['is_compoent_planed_PT_gati_shakti_pipeline'] ?? 0,

      delayWorkReason: List<int>.from(json['listdelay_work_reason'] ?? []),
      costOverrunReason: List<int>.from(json['listcost_overrun_reason'] ?? []),
      costRevisionReason: List<int>.from(json['listcost_revision_reason'] ?? []),

      // New fields
      txtcost_levelzed_cost_cr: (json['txtcost_levelzed_cost_cr'] ?? 0).toDouble(),
      is_tpia_engaged_value: json['is_tpia_engaged_value'] ?? 0,
      concurrent_supervission_scope_value: json['concurrent_supervission_scope_value'] ?? 0,
      txtpws_status_under_scheme: json['txtpws_status_under_scheme'] ?? '',
      phy_status: json['phy_status'] ?? 0,
      scheme_implementation_Remarks: json['scheme_implementation_Remarks'] ?? '',
      Resion_for_delay_after_aword_other: json['Resion_for_delay_after_aword_other'] ?? '',
      Reason_for_revision: json['Reason_for_revision'] ?? '',
      Reason_for_cost_overrun: json['Reason_for_cost_overrun'] ?? '',
    );
  }
}
