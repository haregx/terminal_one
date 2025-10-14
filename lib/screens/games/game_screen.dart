import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/buttons/primary_button.dart';
import 'package:terminal_one/screens/games/game_result_screen.dart';
import 'package:terminal_one/widgets/game/button_group.dart';
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
  final Map<int, List<dynamic>> map = {};
  final String categoryName = 'Code';

  @override
  void initState() {
    super.initState();
    map[0] = ['assets/images/bismarck.png', 'Wie lautet der Vorname dieses Herren?', 1, 'Otto', 'Claus', 'Thomas', 'Daniel', '', false, ''];
    map[1] = ['assets/images/schokolade.png', 'Wer hat\'s erfunden?', 4, 'Die Franzosen', 'Die Griechen', 'Die Römer', 'Die Schweizer', '', false, ''];
    map[2] = ['assets/images/ahorn.png', 'Zu welchem Baum passt dieses Blatt?', 3, 'Eiche', 'Buche', 'Ahorn', 'Kastanie', '', false, ''];
    map[3] = ['assets/images/banana.png', 'Wie viele Bananen sieht man auf dem Bild', 2, '2', '4', '3', '12', '', false, ''];
  }

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
                child: QuizButtonsGroup(
                  callbackNextStep: (bool isCorrect) {

                  },
                  callbackNextPage: (int correctAnswers) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameResultScreen(
                          correctAnswers: correctAnswers.toDouble(),
                          questions: map.length.toDouble(),
                        ),
                      ),
                    );
                  },
                  callbackQuestionClicked: () {

                  },
                  categoryName: categoryName,
                  map: map,
                  sumQuestions: map.length,
                  callbackExplanationClicked: (String question, String htmlText, bool hasKI) {

                  },
                ),
              ),
              // Responsives Grid Layout mit GridView
            ],
          ),
        ),
      ),
    );
  }
}