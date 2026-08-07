import 'package:flutter/material.dart';

import '../../widgets/home_back_scaffold.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBackScaffold(
      title: 'Scan',
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt, size: 120),
            SizedBox(height: 16),
            Text(
              'Coming Soon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
