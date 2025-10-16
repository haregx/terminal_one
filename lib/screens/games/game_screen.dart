import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/screens/games/game_result_screen.dart';
import 'package:terminal_one/widgets/game/button_group.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';
import '../../data/questions.dart';

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
  final String categoryName = 'Code';


  @override
  void initState() {
    super.initState();
    // No longer initializing map here
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: Text('game.title'.tr()),
      
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
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
                            questions: questionsMap.length.toDouble(),
                          ),
                        ),
                      );
                    },
                    callbackQuestionClicked: () {
            
                    },
                    categoryName: categoryName,
                    map: questionsMap,
                    sumQuestions: questionsMap.length,
                    callbackExplanationClicked: (String question, String htmlText, bool hasKI) {
            
                    },
                  ),
                ),
                // Responsives Grid Layout mit GridView
              ],
            ),
          ),
        ),
      ),
    );
  }
}