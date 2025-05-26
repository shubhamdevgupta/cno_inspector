class CnoDashboardResponse {
  final bool status;
  final String message;
  final List<CnoDashboardHomeItem> result;

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
          ?.map((e) => CnoDashboardHomeItem.fromJson(e))
          .toList() ??
          [],
    );
  }
}



class CnoDashboardHomeItem {
  final int totalScheme;
  final int totalDistrict;
  final int totalVillage;
  final int totalSchemeBelow;
  final int totalDistrictBelow;
  final int totalVillageBelow;
  final int totalSchemeUpper;
  final int totalDistrictUpper;
  final int totalVillageUpper;

  CnoDashboardHomeItem({
    required this.totalScheme,
    required this.totalDistrict,
    required this.totalVillage,
    required this.totalSchemeBelow,
    required this.totalDistrictBelow,
    required this.totalVillageBelow,
    required this.totalSchemeUpper,
    required this.totalDistrictUpper,
    required this.totalVillageUpper,
  });

  factory CnoDashboardHomeItem.fromJson(Map<String, dynamic> json) {
    return CnoDashboardHomeItem(
      totalScheme: json['TotalScheme'] ?? 0,
      totalDistrict: json['TotalDistrict'] ?? 0,
      totalVillage: json['TotalVillage'] ?? 0,
      totalSchemeBelow: json['TotalScheme_Below'] ?? 0,
      totalDistrictBelow: json['TotalDistrict_Below'] ?? 0,
      totalVillageBelow: json['TotalVillage_Below'] ?? 0,
      totalSchemeUpper: json['TotalScheme_Upper'] ?? 0,
      totalDistrictUpper: json['TotalDistrict_Upper'] ?? 0,
      totalVillageUpper: json['TotalVillage_Upper'] ?? 0,
    );
  }
}
