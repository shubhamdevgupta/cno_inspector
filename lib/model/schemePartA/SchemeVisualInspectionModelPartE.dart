class SchemeVisualInspectionModel {
  final int userid;
  final int stateid;
  final int schemeid;
  final int costOverrun;
  final int isInspectOfSpallingPeelingOffSurface;
  final int isInspectOfCracks;
  final int isInspectOfRedBrownRustMarks;
  final int isInspectOfSwollenConcrete;
  final int isInspectOfTrappedJutePlasticBags;
  final int isInspectOfProtrudingRustedReinforcementBars;
  final int isInspectOfDampnessOfConcreteSurfaces;
  final int isInspectOfVisibleWhiteMarks;
  final int isInspectOfVisibleStoneAggregates;
  final int isInspectOfStructuresMissingVerticalAlignment;
  final int isInspectOfVisibleSagInTheSlabBeam;
  final int isInspectOfHighVibrationObservedInThePumps;
  final int isInspectOfLeakagesInReservoirs;
  final int isInspectOfHighLeakagesFromThePumps;
  final int isInspectOfPipelinesLeakagesInTransmission;
  final int isInspectOfPipelinesLeakagesInDistribution;
  final int isInspectOfPipelinesWetPatchesPoolOfWater;
  final int whetherQualityVerifyOfManufacturePipeThirdParty;
  final int areThePipesAsMentionInTheDPRImplementOnGround;
  final int areThereAnyComplaintsRegardingPipelineDesignDPR;
  final int isTpiaEngagedForThisScheme;
  final int areSampleBasedQualityChecksPipesCivilKeyComponents;
  final int isConcurrentSupervisionInTheScopeOfTPIA;
  final int hasTpiaConductedQualityChecksAtDifferentStages;
  final int areThereRecordsOfInspectReportsIssuedByTpia;
  final int hasAnyActionBeenTakenBasedOnTpiaObservation;
  final int doesTpiaVerifyMeasurementBooks;
  final int isHydrotestingPipelinesDone;
  final int isTestReportsProvidedSamples;
  final int whetherDeptEngineersDoQualityChecks;
  final int whetherDeptEngVerifyMeasureConstructionWorks;
  final int schemeCommissionedAsPerProtocol;
  final int documentAsProofOfCommissioningAvailable;
  final String? typeOfIssuesTpias;
  final String? typeofissuestpiasOther;
  final String? visualInspectionRemarks;

  SchemeVisualInspectionModel({
    required this.userid,
    required this.stateid,
    required this.schemeid,
    required this.costOverrun,
    required this.isInspectOfSpallingPeelingOffSurface,
    required this.isInspectOfCracks,
    required this.isInspectOfRedBrownRustMarks,
    required this.isInspectOfSwollenConcrete,
    required this.isInspectOfTrappedJutePlasticBags,
    required this.isInspectOfProtrudingRustedReinforcementBars,
    required this.isInspectOfDampnessOfConcreteSurfaces,
    required this.isInspectOfVisibleWhiteMarks,
    required this.isInspectOfVisibleStoneAggregates,
    required this.isInspectOfStructuresMissingVerticalAlignment,
    required this.isInspectOfVisibleSagInTheSlabBeam,
    required this.isInspectOfHighVibrationObservedInThePumps,
    required this.isInspectOfLeakagesInReservoirs,
    required this.isInspectOfHighLeakagesFromThePumps,
    required this.isInspectOfPipelinesLeakagesInTransmission,
    required this.isInspectOfPipelinesLeakagesInDistribution,
    required this.isInspectOfPipelinesWetPatchesPoolOfWater,
    required this.whetherQualityVerifyOfManufacturePipeThirdParty,
    required this.areThePipesAsMentionInTheDPRImplementOnGround,
    required this.areThereAnyComplaintsRegardingPipelineDesignDPR,
    required this.isTpiaEngagedForThisScheme,
    required this.areSampleBasedQualityChecksPipesCivilKeyComponents,
    required this.isConcurrentSupervisionInTheScopeOfTPIA,
    required this.hasTpiaConductedQualityChecksAtDifferentStages,
    required this.areThereRecordsOfInspectReportsIssuedByTpia,
    required this.hasAnyActionBeenTakenBasedOnTpiaObservation,
    required this.doesTpiaVerifyMeasurementBooks,
    required this.isHydrotestingPipelinesDone,
    required this.isTestReportsProvidedSamples,
    required this.whetherDeptEngineersDoQualityChecks,
    required this.whetherDeptEngVerifyMeasureConstructionWorks,
    required this.schemeCommissionedAsPerProtocol,
    required this.documentAsProofOfCommissioningAvailable,
    this.typeOfIssuesTpias,
    this.typeofissuestpiasOther,
    this.visualInspectionRemarks
  });

  factory SchemeVisualInspectionModel.fromJson(Map<String, dynamic> json) {
    return SchemeVisualInspectionModel(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      schemeid: json['schemeid'] ?? 0,
      costOverrun: json['cost_overrun'] ?? 0,
      isInspectOfSpallingPeelingOffSurface: json['is_inspect_of_spalling_peeling_off_surface'] ?? 0,
      isInspectOfCracks: json['is_inspect_of_cracks'] ?? 0,
      isInspectOfRedBrownRustMarks: json['is_inspect_of_red_brown_rust_marks'] ?? 0,
      isInspectOfSwollenConcrete: json['is_inspect_of_swollen_concrete'] ?? 0,
      isInspectOfTrappedJutePlasticBags: json['is_inspect_of_trapped_jute_plastic_bags'] ?? 0,
      isInspectOfProtrudingRustedReinforcementBars: json['is_inspect_of_protruding_rusted_reinforcement_bars'] ?? 0,
      isInspectOfDampnessOfConcreteSurfaces: json['is_inspect_of_dampness_of_concrete_surfaces'] ?? 0,
      isInspectOfVisibleWhiteMarks: json['is_inspect_of_visible_white_marks'] ?? 0,
      isInspectOfVisibleStoneAggregates: json['is_inspect_of_visible_stone_aggregates'] ?? 0,
      isInspectOfStructuresMissingVerticalAlignment: json['is_inspect_of_structures_missing_vertical_alignment'] ?? 0,
      isInspectOfVisibleSagInTheSlabBeam: json['is_inspect_of_visible_sag_in_the_slab_beam'] ?? 0,
      isInspectOfHighVibrationObservedInThePumps: json['is_inspect_of_high_vibration_observed_in_the_pumps'] ?? 0,
      isInspectOfLeakagesInReservoirs: json['is_inspect_of_leakages_in_reservoirs'] ?? 0,
      isInspectOfHighLeakagesFromThePumps: json['is_inspect_of_high_leakages_from_the_pumps'] ?? 0,
      isInspectOfPipelinesLeakagesInTransmission: json['is_inspect_of_Pipelines_leakages_in_transmission'] ?? 0,
      isInspectOfPipelinesLeakagesInDistribution: json['is_inspect_of_Pipelines_leakages_in_distribution'] ?? 0,
      isInspectOfPipelinesWetPatchesPoolOfWater: json['is_inspect_of_Pipelines_wet_patches_pool_of_water'] ?? 0,
      whetherQualityVerifyOfManufacturePipeThirdParty: json['whether_quality_verify_of_manufacture_pipe_third_party'] ?? 0,
      areThePipesAsMentionInTheDPRImplementOnGround: json['are_the_pipes_as_mention_in_the_DPR_implement_on_ground'] ?? 0,
      areThereAnyComplaintsRegardingPipelineDesignDPR: json['are_there_any_complaints_regard_pipeline_approve_design_DPR'] ?? 0,
      isTpiaEngagedForThisScheme: json['is_tpia_engaged_for_this_scheme'] ?? 0,
      areSampleBasedQualityChecksPipesCivilKeyComponents: json['are_sample_based_quality_checks_pipes_civil_key_components'] ?? 0,
      isConcurrentSupervisionInTheScopeOfTPIA: json['is_concurrent_supervision_in_the_scope_of_TPIA'] ?? 0,
      hasTpiaConductedQualityChecksAtDifferentStages: json['has_tpia_cond_quality_checks_diff_stages_of_construction'] ?? 0,
      areThereRecordsOfInspectReportsIssuedByTpia: json['are_there_records_of_observ_inspect_reports_issued_tpia'] ?? 0,
      hasAnyActionBeenTakenBasedOnTpiaObservation: json['has_any_action_taken_by_dept_based_on_tpia_observation'] ?? 0,
      doesTpiaVerifyMeasurementBooks: json['does_tpia_verify_measurement_books'] ?? 0,
      isHydrotestingPipelinesDone: json['is_hydrotesting_pipelines_done'] ?? 0,
      isTestReportsProvidedSamples: json['is_test_reports_provided_samples'] ?? 0,
      whetherDeptEngineersDoQualityChecks: json['whether_dept_engineers_do_quality_checks'] ?? 0,
      whetherDeptEngVerifyMeasureConstructionWorks: json['whether_dept_eng_verify_measure_construction_works'] ?? 0,
      schemeCommissionedAsPerProtocol: json['scheme_commissioned_done_per_commissioning_protocol'] ?? 0,
      documentAsProofOfCommissioningAvailable: json['document_as_proof_of_commissioning_available'] ?? 0,
      typeOfIssuesTpias: json['type_of_issues_tpias'],
      typeofissuestpiasOther: json['type_of_issues_tpias_Other'],
      visualInspectionRemarks: json['visual_Inspection_Remarks'],
    );
  }
}
