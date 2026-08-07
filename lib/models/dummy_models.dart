class HistoryItem {
  final String title;
  final String time;
  final int calories;

  const HistoryItem({
    required this.title,
    required this.time,
    required this.calories,
  });
}

class ProfileData {
  final String name;
  final String email;
  final String gender;
  final double currentWeight;
  final double targetWeight;
  final double height;

  const ProfileData({
    required this.name,
    required this.email,
    required this.gender,
    required this.currentWeight,
    required this.targetWeight,
    required this.height,
  });
}
