class CoordinationPlanningReview {
  final int userid;
  final int stateid;
  final int districtid;
  final int areMonthlyDwsmMeetingsOnProgressJjmWorks;
  final int ifYesNoOfDwsmMeetingsLast6Months;
  final int qualityOfMeetingAndRecordMaintenance;
  final int areDistDevelopCoordinatMonitorCommitteeMeetingRegularly;

  CoordinationPlanningReview({
    required this.userid,
    required this.stateid,
    required this.districtid,
    required this.areMonthlyDwsmMeetingsOnProgressJjmWorks,
    required this.ifYesNoOfDwsmMeetingsLast6Months,
    required this.qualityOfMeetingAndRecordMaintenance,
    required this.areDistDevelopCoordinatMonitorCommitteeMeetingRegularly,
  });

  factory CoordinationPlanningReview.fromJson(Map<String, dynamic> json) {
    return CoordinationPlanningReview(
      userid: json['userid'],
      stateid: json['stateid'],
      districtid: json['districtid'],
      areMonthlyDwsmMeetingsOnProgressJjmWorks:
      json['are_monthly_dwsm_meetings_on_progress_JJM_works'],
      ifYesNoOfDwsmMeetingsLast6Months:
      json['if_yes_no_of_dwsm_meetings_last_6_months'],
      qualityOfMeetingAndRecordMaintenance:
      json['quality_of_meeting_and_record_maintenance'],
      areDistDevelopCoordinatMonitorCommitteeMeetingRegularly:
      json['are_dist_develop_coordinat_monitor_committee_meeting_regularly'],
    );
  }
}
