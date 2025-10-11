import 'package:flutter/material.dart';
import 'package:terminal_one/components/buttons/primary_button.dart';
import 'package:terminal_one/screens/games/game_screen.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';

class GameDetailsScreen extends StatefulWidget {
  
  const GameDetailsScreen({
    super.key,
  });

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  // Lade Promo-Karten aus zentraler Datenquelle
  final List<PromoData> promoCards = PromoDataSource.getAllCards();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('Game Details'),
      
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Bla bla bla.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(166),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Responsives Grid Layout mit GridView
              Expanded(
                child: Center(
                  child: PrimaryButton(
                    label: 'Game',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                    },
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}