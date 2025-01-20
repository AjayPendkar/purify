class ActivityModel {
  final String time;
  final String title;
  final String description;
  final String period; // 'Morning', 'Afternoon', etc.
  
  ActivityModel({
    required this.time,
    required this.title,
    required this.description,
    required this.period,
  });
} 