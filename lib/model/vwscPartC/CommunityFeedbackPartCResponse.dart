class CommunityFeedback {
  final int userid;
  final int stateid;
  final int villageid;
  final int anyComplaintByCommunity;
  final int isComplaintAddressed;
  final List<int> complaintType;

  /// New parameter added to capture observation or remarks by the user
  final String observationCommunityFeedbackQualityConstruction;

  CommunityFeedback({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.anyComplaintByCommunity,
    required this.isComplaintAddressed,
    required this.complaintType,
    required this.observationCommunityFeedbackQualityConstruction, // <-- New parameter
  });

  factory CommunityFeedback.fromJson(Map<String, dynamic> json) {
    return CommunityFeedback(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      anyComplaintByCommunity: json['any_complaint_by_community'],
      isComplaintAddressed: json['is_complaint_addressed'],
      complaintType: List<int>.from(json['complaint_type']),

      /// Parsing the new field from JSON response
      observationCommunityFeedbackQualityConstruction: json['observation_community_feedback_quality_construction'], // <-- New parameter
    );
  }
}
