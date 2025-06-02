class SourceSustainabilityWaterConservation {
  final int userid;
  final int stateid;
  final int districtid;
  final int areSourceSustainabilityMeasuresBeingPromoted;
  final int arePipedWaterSchemesGwSourcesProtectedContamination;
  final int isAtLeastOneRechargeStructureGwSourceImplemented;
  final String ifNoLeastOneRechargeStructureGwSourceImplementedReson;
  final int areAnyImpactStudiesAssessmentsConductedSourceSustainEfforts;
  final int accrediteLabWaterQuality;
  final String accrediteLabWaterQualityNoRemark;
  final int modeType;
  final String userremark;

  SourceSustainabilityWaterConservation(
      {required this.userid,
      required this.stateid,
      required this.districtid,
      required this.areSourceSustainabilityMeasuresBeingPromoted,
      required this.arePipedWaterSchemesGwSourcesProtectedContamination,
      required this.isAtLeastOneRechargeStructureGwSourceImplemented,
      required this.ifNoLeastOneRechargeStructureGwSourceImplementedReson,
      required this.areAnyImpactStudiesAssessmentsConductedSourceSustainEfforts,
      required this.accrediteLabWaterQualityNoRemark,
      required this.accrediteLabWaterQuality,
      required this.modeType,
      required this.userremark,

      });

  factory SourceSustainabilityWaterConservation.fromJson(
      Map<String, dynamic> json) {
    return SourceSustainabilityWaterConservation(
        userid: json['userid'],
        stateid: json['stateid'],
        districtid: json['districtid'],
        areSourceSustainabilityMeasuresBeingPromoted: json['are_source_sustainability_measures_being_promoted'],
        arePipedWaterSchemesGwSourcesProtectedContamination: json['are_piped_water_schemes_gw_sources_protected_contamination'],
        isAtLeastOneRechargeStructureGwSourceImplemented: json['is_at_least_one_recharge_structure_gw_source_implemented'],
        ifNoLeastOneRechargeStructureGwSourceImplementedReson: json['if_no_least_one_recharge_structure_gw_source_implemented_reson'],
        areAnyImpactStudiesAssessmentsConductedSourceSustainEfforts: json['are_any_impact_studies_assessments_conducted_source_sustain_efforts'],
        accrediteLabWaterQuality: json['Does_district_NABL_accredited_lab_water_quality'],
        accrediteLabWaterQualityNoRemark: json['Does_district_NABL_accredited_lab_water_quality_no_remark'],
        modeType: json['phy_status'],
        userremark: json['Obseration_source_sustainability_water_conservation']


    );

  }
}
