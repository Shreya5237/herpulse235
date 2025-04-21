// lib/models/planning_pregnancy_data.dart

class PlanningPregnancyData {
  final bool tryingToConceive;
  final DateTime? lastOvulationDate;
  final bool pregnancyConfirmed;
  final double weeklyWeight;
  final String bloodPressure;
  final double stressLevel;
  final String fetalNotes;

  PlanningPregnancyData({
    required this.tryingToConceive,
    this.lastOvulationDate,
    required this.pregnancyConfirmed,
    required this.weeklyWeight,
    required this.bloodPressure,
    required this.stressLevel,
    required this.fetalNotes,
  });
}
