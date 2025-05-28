class CommunityInvolvement {
  final int userid;
  final int stateid;
  final int villageid;
  final int isPaniSamitiFormed;
  final int isVwscBankAccount;
  final int vwscGpInvolvementScheme;
  final int drawingPipelineAvlGpOffice;
  final int isVwscMeetingPeriodicManner;
  final String meetingHeldYesFrequency;
  final int isVwscMeetingRecordAvl;
  final int vwscInvolvementOm;
  final int schemeHandedOverGp;
  final int omArrangement;
  final int communityAwareness;
  final int communitySatisfactionWithWq;
  final int createdby;
  final String? createdip;
  final int phyStatus;
  final String observationCommunityInvolvementFunctionality;

  CommunityInvolvement({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.isPaniSamitiFormed,
    required this.isVwscBankAccount,
    required this.vwscGpInvolvementScheme,
    required this.drawingPipelineAvlGpOffice,
    required this.isVwscMeetingPeriodicManner,
    required this.meetingHeldYesFrequency,
    required this.isVwscMeetingRecordAvl,
    required this.vwscInvolvementOm,
    required this.schemeHandedOverGp,
    required this.omArrangement,
    required this.communityAwareness,
    required this.communitySatisfactionWithWq,
    required this.createdby,
    required this.createdip,
    required this.phyStatus,
    required this.observationCommunityInvolvementFunctionality,
  });

  factory CommunityInvolvement.fromJson(Map<String, dynamic> json) {
    return CommunityInvolvement(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      isPaniSamitiFormed: json['is_pani_samiti_formed'],
      isVwscBankAccount: json['is_vwsc_bank_account'],
      vwscGpInvolvementScheme: json['vwsc_gp_involvement_scheme'],
      drawingPipelineAvlGpOffice: json['drawing_pipeline_avl_gp_office'],
      isVwscMeetingPeriodicManner: json['is_vwsc_meeting_periodic_manner'],
      meetingHeldYesFrequency: json['meeting_held_yes_frequency'],
      isVwscMeetingRecordAvl: json['is_vwsc_meeting_record_avl'],
      vwscInvolvementOm: json['vwsc_involvement_om'],
      schemeHandedOverGp: json['scheme_handed_over_gp'],
      omArrangement: json['om_arrangement'],
      communityAwareness: json['community_awareness'],
      communitySatisfactionWithWq: json['community_satisfaction_with_wq'],
      createdby: json['createdby'],
      createdip: json['createdip'],
      phyStatus: json['phy_status'],
      observationCommunityInvolvementFunctionality:
      json['ObservationCommunity_Involvement_Functionality'],
    );
  }
}
