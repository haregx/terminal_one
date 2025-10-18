import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:terminal_one/screens/statics/policy_screen.dart';
import 'package:terminal_one/screens/statics/privacy_screen.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/screens/games/game_screen.dart';
import 'package:terminal_one/widgets/spacer/responsive_spacer.dart';
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
      title: Text('game.details_title'.tr()),
      
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Responsives Grid Layout mit GridView
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                        Image.asset(
                          'assets/images/schokolade.png',
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Html(
                                data: '''
                                <h2>App-Akademie Schokolade</h2>
                                <p><strong>Lorem ipsum dolor sit amet</strong>, consectetur adipiscing elit. <em>Etiam euismod</em> tincidunt velit, nec facilisis massa dictum nec.</p>
                                <ul>
                                  <li>Curabitur blandit tempus porttitor.</li>
                                  <li>Maecenas faucibus mollis interdum.</li>
                                  <li>Nullam quis risus eget urna mollis ornare vel eu leo.</li>
                                </ul>
                                <p>Donec ullamcorper nulla non metus auctor fringilla. <a href="#">Learn more</a></p>
                              '''
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ResponsiveSpacing.large(context)),
                        
                    ],
                  ),
                ),
              ),
              Center(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      IntrinsicWidth(
                        child: Button3D(
                          enabled: _privacyAccepted && _policyAccepted,
                          label: 'game.start'.tr(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GameScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}