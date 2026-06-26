import 'package:flutter/material.dart';

import '../../models/dummy_models.dart';
import '../../routes/app_routes.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  List<HistoryItem> get dummyHistory => const [
        HistoryItem(title: 'Ayam Panggang', time: '08:15', calories: 450),
        HistoryItem(title: 'Nasi + Telur', time: '12:30', calories: 520),
        HistoryItem(title: 'Salad Buah', time: '17:45', calories: 180),
        HistoryItem(title: 'Sate Ayam', time: '20:10', calories: 330),
      ];

  @override
  Widget build(BuildContext context) {
    final items = dummyHistory;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
        ),
        title: const Text('History'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant_menu, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text('Waktu: ${item.time}'),
                        ],
                      ),
                    ),
                    Text('${item.calories} kcal'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
