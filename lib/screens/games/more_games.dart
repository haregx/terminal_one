import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MoreGamesScreen extends StatefulWidget {
  const MoreGamesScreen({super.key});

  @override
  State<MoreGamesScreen> createState() => _MoreGamesScreenState();
}

class _MoreGamesScreenState extends State<MoreGamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Games'),
        leading: BackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(LucideIcons.gamepad2, size: 64),
            SizedBox(height: 24),
            Text('Hier findest du bald mehr Promo-Games!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
