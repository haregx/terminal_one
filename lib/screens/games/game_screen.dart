import 'package:flutter/material.dart';
import 'package:terminal_one/components/buttons/primary_button.dart';
import 'package:terminal_one/screens/games/game_result_screen.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';

class GameScreen extends StatefulWidget {
  
  const GameScreen({
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Lade Promo-Karten aus zentraler Datenquelle
  final List<PromoData> promoCards = PromoDataSource.getAllCards();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('Game'),
      
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Bla bla bla',
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
                    label: 'Result',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameResultScreen(),
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