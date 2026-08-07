import 'package:flutter/material.dart';

import '../../data/history_repository.dart';
import '../../widgets/home_back_scaffold.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryRepository _repository;

  const HistoryScreen(
      {super.key, HistoryRepository repository = const HistoryRepository()})
      : _repository = repository;

  @override
  Widget build(BuildContext context) {
    final items = _repository.getAll();

    return HomeBackScaffold(
      title: 'History',
      body: ListView.separated(
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
    );
  }
}
