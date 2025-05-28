/// Model class representing the community feedback data.
class CommunityFeedback {
  final int userid;
  final int stateid;
  final int villageid;
  final int anyComplaintByCommunity;
  final int isComplaintAddressed;
  final List<int> complaintType;
  final String complaintTypeIds; // <-- New variable to store comma-separated complaint type IDs.
  final String observationCommunityFeedbackQualityConstruction;

  /// Constructor for initializing the class.
  CommunityFeedback({
    required this.userid,
    required this.stateid,
    required this.villageid,
    required this.anyComplaintByCommunity,
    required this.isComplaintAddressed,
    required this.complaintType,
    required this.complaintTypeIds, // <-- Added here
    required this.observationCommunityFeedbackQualityConstruction,
  });

  /// Factory method to create an instance from JSON.
  factory CommunityFeedback.fromJson(Map<String, dynamic> json) {
    return CommunityFeedback(
      userid: json['userid'] ?? 0,
      stateid: json['stateid'] ?? 0,
      villageid: json['villageid'] ?? 0,
      anyComplaintByCommunity: json['any_complaint_by_community'] ?? 0,
      isComplaintAddressed: json['is_complaint_addressed'] ?? 0,

      /// Convert JSON array to List<int>.
      complaintType: json['complainttype'] != null
          ? List<int>.from(json['complainttype'])
          : [],

      /// Read the complaintTypeIds field from JSON, or set it as an empty string if missing.
      complaintTypeIds: json['complaint_typeIds'] ?? '', // <-- Added here

      /// Handle potential missing key for the observation field.
      observationCommunityFeedbackQualityConstruction:
      json['ObservationCommunity_feedback_quality_construction'] ?? '',
    );
  }

  /// Method to convert the object to JSON.
  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'stateid': stateid,
      'villageid': villageid,
      'any_complaint_by_community': anyComplaintByCommunity,
      'is_complaint_addressed': isComplaintAddressed,

      /// Convert List<int> to JSON.
      'complainttype': complaintType,

      /// Save complaintTypeIds as a separate field.
      'complaint_typeIds': complaintTypeIds, // <-- Added here

      'ObservationCommunity_feedback_quality_construction':
      observationCommunityFeedbackQualityConstruction,
    };
  }
}
