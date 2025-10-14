import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/screens/common/policy_screen.dart';
import 'package:terminal_one/screens/common/privacy_screen.dart';
import 'package:terminal_one/utils/responsive_layout.dart';
import 'package:terminal_one/widgets/buttons/primary_button.dart';
import 'package:terminal_one/screens/games/game_screen.dart';
import 'package:terminal_one/widgets/switches/text_right_switch.dart';
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
  bool _privacyAccepted = false;
  bool _policyAccepted = false;

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
              // Responsives Grid Layout mit GridView
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                        Placeholder(),
                    ],
                  ),
                ),
              ),
              Center(

                child: Column(
                  spacing: ResponsiveSpacing.large(context),
                  children: [
                    SimpleSwitchLeftWithText(
                      value: _privacyAccepted, 
                      onLabelTap: () async {
                        var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PrivacyScreen(showBottomButtons: true,),
                          ),
                        );
                        if (result != null) {
                          setState(() { _privacyAccepted = result; });
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _privacyAccepted = value;
                        });
                      }, 
                      label: 'auth.privacy_policy_accept'.tr()
                    ),
                    SimpleSwitchLeftWithText(
                      value: _policyAccepted, 
                      onLabelTap: () async {
                        var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PolicyScreen(showBottomButtons: true,),
                          ),
                        );
                        if (result != null) {
                          setState(() { _policyAccepted = result; });
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          _policyAccepted = value;
                        });
                      }, 
                      label: 'auth.policy_accept'.tr()
                    ),
                    PrimaryButton(
                      enabled: _privacyAccepted && _policyAccepted,
                      label: 'Play',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}