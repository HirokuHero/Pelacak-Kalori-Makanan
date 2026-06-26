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
  final double targetWeight;

  const ProfileData({
    required this.name,
    required this.email,
    required this.targetWeight,
  });
}

