import 'package:flutter/material.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('Privacy Policy'),
      body: AppBarAwareSafeArea(
        child: const Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Text(
            'Here you can display your privacy policy text.\n\nAdd your content here.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ),
      ),
    );
  }
}
