class CnoDashboardResponse {
  final bool status;
  final String message;
  final List<CnoDashboardItem> result;

  CnoDashboardResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory CnoDashboardResponse.fromJson(Map<String, dynamic> json) {
    return CnoDashboardResponse(
      status: json['Status'] ?? false,
      message: json['Message'] ?? '',
      result: (json['Result'] as List<dynamic>?)
          ?.map((e) => CnoDashboardItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class CnoDashboardItem {
  final int userId;
  final String? userName;
  final String? designation;
  final String? mobileNumber;

  final int totalSchemes;
  final int pendingSchemes;
  final int underProcessSchemes;

  final int totalDistricts;
  final int pendingDistricts;
  final int underProcessDistricts;

  final int totalVillages;
  final int pendingVillages;
  final int underProcessVillages;

  final int schemeId;
  final String schemeName;

  final int stateId;
  final String? stateName;

  final int districtId;
  final String? districtName;

  final int blockId;
  final String? blockName;

  final int panchayatId;
  final String? panchayatName;

  final int villageId;
  final String? villageName;

  CnoDashboardItem({
    required this.userId,
    this.userName,
    this.designation,
    this.mobileNumber,
    required this.totalSchemes,
    required this.pendingSchemes,
    required this.underProcessSchemes,
    required this.totalDistricts,
    required this.pendingDistricts,
    required this.underProcessDistricts,
    required this.totalVillages,
    required this.pendingVillages,
    required this.underProcessVillages,
    required this.schemeId,
    required this.schemeName,
    required this.stateId,
    this.stateName,
    required this.districtId,
    this.districtName,
    required this.blockId,
    this.blockName,
    required this.panchayatId,
    this.panchayatName,
    required this.villageId,
    this.villageName,
  });

  factory CnoDashboardItem.empty() {
    return CnoDashboardItem(
      userId: 0,
      userName: '',
      designation: '',
      mobileNumber: '',
      totalSchemes: 0,
      pendingSchemes: 0,
      underProcessSchemes: 0,
      totalDistricts: 0,
      pendingDistricts: 0,
      underProcessDistricts: 0,
      totalVillages: 0,
      pendingVillages: 0,
      underProcessVillages: 0,
      schemeId: 0,
      schemeName: '',
      stateId: 0,
      stateName: '',
      districtId: 0,
      districtName: '',
      blockId: 0,
      blockName: '',
      panchayatId: 0,
      panchayatName: '',
      villageId: 0,
      villageName: '',
    );
  }
  factory CnoDashboardItem.fromJson(Map<String, dynamic> json) {
    return CnoDashboardItem(
      userId: json['userid'] ?? 0,
      userName: json['userName'],
      designation: json['Designation'],
      mobileNumber: json['MobileNumber'],
      totalSchemes: json['total_schemes'] ?? 0,
      pendingSchemes: json['pending_schemes'] ?? 0,
      underProcessSchemes: json['under_process_scheme'] ?? 0,
      totalDistricts: json['total_districts'] ?? 0,
      pendingDistricts: json['pending_districts'] ?? 0,
      underProcessDistricts: json['under_process_districts'] ?? 0,
      totalVillages: json['total_villages'] ?? 0,
      pendingVillages: json['pending_villages'] ?? 0,
      underProcessVillages: json['under_process_villages'] ?? 0,
      schemeId: json['SchemeId'] ?? 0,
      schemeName: json['SchemeName'],
      stateId: json['stateid'] ?? 0,
      stateName: json['StateName'],
      districtId: json['districtid'] ?? 0,
      districtName: json['DistrictName'],
      blockId: json['BlockId'] ?? 0,
      blockName: json['BlockName'],
      panchayatId: json['PanchayatId'] ?? 0,
      panchayatName: json['PanchayatName'],
      villageId: json['VillageId'] ?? 0,
      villageName: json['VillageName'],
    );
  }
}


