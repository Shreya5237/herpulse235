// lib/models/menstrual_data.dart

class MenstrualData {
  final DateTime startDate;
  final DateTime endDate;
  final String flowIntensity;
  final int painLevel;
  final List<String> symptoms;
  final String productPreference;

  MenstrualData({
    required this.startDate,
    required this.endDate,
    required this.flowIntensity,
    required this.painLevel,
    required this.symptoms,
    required this.productPreference,
  });
}
