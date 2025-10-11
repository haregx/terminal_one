import 'package:flutter/material.dart';
import 'package:terminal_one/components/buttons/primary_button.dart';
import 'package:terminal_one/screens/home/home_screen_router.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';

class GameResultScreen extends StatefulWidget {
  
  const GameResultScreen({
    super.key,
  });

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  // Lade Promo-Karten aus zentraler Datenquelle
  final List<PromoData> promoCards = PromoDataSource.getAllCards();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('Game Result'),
      
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
                    label: 'Home',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreenRouter(),
                        ),
                        (route) => false,
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