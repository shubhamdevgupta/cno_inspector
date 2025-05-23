import 'package:cno_inspection/repository/schemeInfoRepo/SchemeRepository.dart';
import 'package:flutter/cupertino.dart';

class Schemeprovider extends ChangeNotifier {
  final SchemeRepositoy _schemeRepositoy = SchemeRepositoy();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _message;
  String? get message => _message;

  bool? _status;
  bool? get status => _status;

  Future<bool> saveSourceSurvey({
    required int userId,
    required int stateId,
    required int schemeId,
    required int isRecommendShiftToSurface,
    required int studyAccessGroundBeforeSurface,
    required int safeZoneVillages,
    required int criticalZoneVillages,
    required int semiCriticalZoneVillages,
    required int groundWaterAnalysisConducted,
    required int waterAllocationFromWRD,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveSourceSurvey(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        isRecommendShiftToSurface: isRecommendShiftToSurface,
        studyAccessGroundBeforeSurface: studyAccessGroundBeforeSurface,
        safeZoneVillages: safeZoneVillages,
        criticalZoneVillages: criticalZoneVillages,
        semiCriticalZoneVillages: semiCriticalZoneVillages,
        groundWaterAnalysisConducted: groundWaterAnalysisConducted,
        waterAllocationFromWRD: waterAllocationFromWRD,
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveSchemePlanning({
    required int userId,
    required int stateId,
    required int schemeId,
    required int topoSurvey,
    required int gpsSurvey,
    required int googleSurvey,
    required int numberOfSurveys,
    required int designRunningHours,
    required int retentionTimeOHT,
    required int retentionTimeMBR,
    required String terrainRocky,
    required String terrainSoil,
    required int foundAsPerDPR,
    required String deviation,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveSchemePlanning(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        topoSurvey: topoSurvey,
        gpsSurvey: gpsSurvey,
        googleSurvey: googleSurvey,
        numberOfSurveys: numberOfSurveys,
        designRunningHours: designRunningHours,
        retentionTimeOHT: retentionTimeOHT,
        retentionTimeMBR: retentionTimeMBR,
        terrainRocky: terrainRocky,
        terrainSoil: terrainSoil,
        foundAsPerDPR: foundAsPerDPR,
        deviation: deviation,
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveRetrofitAdditionalInfo({
    required int userId,
    required int stateId,
    required int schemeId,
    required int isAssessmentDone,
    required String assessmentMethod,
    required String assessmentReason,
    required double pipelineKms,
    required double distributionKms,
    required double wtpCapacity,
    required int structureNos,
    required double structureCapacity,
    required int buildDrawingAvailable,
    required int onPMGati,
    required String noReason,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveRetrofitAdditionalInfo(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        isAssessmentDone: isAssessmentDone,
        assessmentMethod: assessmentMethod,
        assessmentReason: assessmentReason,
        pipelineKms: pipelineKms,
        distributionKms: distributionKms,
        wtpCapacity: wtpCapacity,
        structureNos: structureNos,
        structureCapacity: structureCapacity,
        buildDrawingAvailable: buildDrawingAvailable,
        onPMGati: onPMGati,
        noReason: noReason,
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveSchemeImplementation({
    required int userId,
    required int stateId,
    required int schemeId,
    required int costOverrun,
    required int costRevisedBeforeWork,
    required int revisedCostPercentage,
    required String slsscDate,
    required int intakeTubeWellNum,
    required double intakeTubeWellCost,
    required int electroMechanicalNum,
    required double electroMechanicalCost,
    required int wtpNum,
    required double wtpCost,
    required int mbrNum,
    required double mbrCost,
    required int transmissionPipelineNum,
    required double transmissionPipelineCost,
    required int distributionPipelineNum,
    required double distributionPipelineCost,
    required int disinfectionUnitNum,
    required double disinfectionUnitCost,
    required int ohtNum,
    required double ohtCost,
    required int iotNum,
    required double iotCost,
    required int roadRestorationNum,
    required double roadRestorationCost,
    required int solarComponentNum,
    required double solarComponentCost,
    required int otherComponentsNum,
    required double otherComponentsCost,
    required int plannedPTGatiShaktiWTP,
    required int plannedPTGatiShaktiOHT,
    required int plannedPTGatiShaktiSource,
    required int plannedPTGatiShaktiPipeline,
    required List<int> delayReasons,
    required List<int> costOverrunReasons,
    required List<int> costRevisionReasons,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveSchemeImplementation(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        costOverrun: costOverrun,
        costRevisedBeforeWork: costRevisedBeforeWork,
        revisedCostPercentage: revisedCostPercentage,
        slsscDate: slsscDate,
        intakeTubeWellNum: intakeTubeWellNum,
        intakeTubeWellCost: intakeTubeWellCost,
        electroMechanicalNum: electroMechanicalNum,
        electroMechanicalCost: electroMechanicalCost,
        wtpNum: wtpNum,
        wtpCost: wtpCost,
        mbrNum: mbrNum,
        mbrCost: mbrCost,
        transmissionPipelineNum: transmissionPipelineNum,
        transmissionPipelineCost: transmissionPipelineCost,
        distributionPipelineNum: distributionPipelineNum,
        distributionPipelineCost: distributionPipelineCost,
        disinfectionUnitNum: disinfectionUnitNum,
        disinfectionUnitCost: disinfectionUnitCost,
        ohtNum: ohtNum,
        ohtCost: ohtCost,
        iotNum: iotNum,
        iotCost: iotCost,
        roadRestorationNum: roadRestorationNum,
        roadRestorationCost: roadRestorationCost,
        solarComponentNum: solarComponentNum,
        solarComponentCost: solarComponentCost,
        otherComponentsNum: otherComponentsNum,
        otherComponentsCost: otherComponentsCost,
        plannedPTGatiShaktiWTP: plannedPTGatiShaktiWTP,
        plannedPTGatiShaktiOHT: plannedPTGatiShaktiOHT,
        plannedPTGatiShaktiSource: plannedPTGatiShaktiSource,
        plannedPTGatiShaktiPipeline: plannedPTGatiShaktiPipeline,
        delayReasons: delayReasons,
        costOverrunReasons: costOverrunReasons,
        costRevisionReasons: costRevisionReasons,
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveVisualInspection({
    required int userId,
    required int stateId,
    required int schemeId,
    required int costOverrun,
    required int spalling,
    required int cracks,
    required int rustMarks,
    required int swollenConcrete,
    required int trappedJute,
    required int rustedBars,
    required int dampness,
    required int whiteMarks,
    required int stoneAggregates,
    required int verticalAlignment,
    required int sagSlabBeam,
    required int highVibrationPumps,
    required int reservoirLeakage,
    required int highLeakagePumps,
    required int pipelineLeakageTransmission,
    required int pipelineLeakageDistribution,
    required int wetPatches,
    required int verifyPipeQuality,
    required int pipesAsPerDPR,
    required int complaintsOnPipelineDesign,
    required int isTPIAEngaged,
    required int sampleChecks,
    required int concurrentSupervision,
    required int tpiaStageChecks,
    required int tpiaReports,
    required int actionOnTPIA,
    required int tpiaVerifyMB,
    required int hydroTestingDone,
    required int testReportsProvided,
    required int deptQualityChecks,
    required int deptMeasurementVerification,
    required int schemeCommissioned,
    required int commissioningProofAvailable,
    required List<int> tpiaIssueTypes,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _schemeRepositoy.saveVisualInspection(
        userId: userId,
        stateId: stateId,
        schemeId: schemeId,
        costOverrun: costOverrun,
        spalling: spalling,
        cracks: cracks,
        rustMarks: rustMarks,
        swollenConcrete: swollenConcrete,
        trappedJute: trappedJute,
        rustedBars: rustedBars,
        dampness: dampness,
        whiteMarks: whiteMarks,
        stoneAggregates: stoneAggregates,
        verticalAlignment: verticalAlignment,
        sagSlabBeam: sagSlabBeam,
        highVibrationPumps: highVibrationPumps,
        reservoirLeakage: reservoirLeakage,
        highLeakagePumps: highLeakagePumps,
        pipelineLeakageTransmission: pipelineLeakageTransmission,
        pipelineLeakageDistribution: pipelineLeakageDistribution,
        wetPatches: wetPatches,
        verifyPipeQuality: verifyPipeQuality,
        pipesAsPerDPR: pipesAsPerDPR,
        complaintsOnPipelineDesign: complaintsOnPipelineDesign,
        isTPIAEngaged: isTPIAEngaged,
        sampleChecks: sampleChecks,
        concurrentSupervision: concurrentSupervision,
        tpiaStageChecks: tpiaStageChecks,
        tpiaReports: tpiaReports,
        actionOnTPIA: actionOnTPIA,
        tpiaVerifyMB: tpiaVerifyMB,
        hydroTestingDone: hydroTestingDone,
        testReportsProvided: testReportsProvided,
        deptQualityChecks: deptQualityChecks,
        deptMeasurementVerification: deptMeasurementVerification,
        schemeCommissioned: schemeCommissioned,
        commissioningProofAvailable: commissioningProofAvailable,
        tpiaIssueTypes: tpiaIssueTypes,
      );

      _message = response.message;
      _status = response.status;
      return _status ?? false;
    } catch (e) {
      _message = 'Something went wrong';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}
