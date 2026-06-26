import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            },
          ),
          title: const Text('Scan'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.camera_alt, size: 120),
                SizedBox(height: 16),
                Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
