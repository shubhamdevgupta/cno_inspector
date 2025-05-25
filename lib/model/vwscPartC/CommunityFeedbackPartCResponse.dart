class CommunityFeedback {
  final int userid;
  final int stateid;
  final int villageid;
  final int anyComplaintByCommunity;
  final int isComplaintAddressed;
  final List<int> complaintType;

  CommunityFeedback({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.anyComplaintByCommunity,
    required this.isComplaintAddressed,
    required this.complaintType,
  });

  factory CommunityFeedback.fromJson(Map<String, dynamic> json) {
    return CommunityFeedback(
      userid: json['userid'],
      stateid: json['stateid'],
      villageid: json['villageid'],
      anyComplaintByCommunity: json['any_complaint_by_community'],
      isComplaintAddressed: json['is_complaint_addressed'],
      complaintType: List<int>.from(json['complaint_type']),
    );
  }
}
