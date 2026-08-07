import '../models/dummy_models.dart';

/// Provides history data. Currently backed by dummy data;
/// swap the implementation for a real data source later.
class HistoryRepository {
  const HistoryRepository();

  List<HistoryItem> getAll() {
    return const [
      HistoryItem(title: 'Ayam Panggang', time: '08:15', calories: 450),
      HistoryItem(title: 'Nasi + Telur', time: '12:30', calories: 520),
      HistoryItem(title: 'Salad Buah', time: '17:45', calories: 180),
      HistoryItem(title: 'Sate Ayam', time: '20:10', calories: 330),
    ];
  }
}
