import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:terminal_one/widgets/buttons/primary_button.dart';
import 'package:terminal_one/screens/home/home_screen_router.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';

class GameResultScreen extends StatefulWidget {
  
  const GameResultScreen({
    super.key,
    required this.correctAnswers,
    required this.questions,
  });

  final double correctAnswers;
  final double questions;

  @override
  State<GameResultScreen> createState() => _GameResultScreenState();
}

class _GameResultScreenState extends State<GameResultScreen> {
  // Lade Promo-Karten aus zentraler Datenquelle
  final List<PromoData> promoCards = PromoDataSource.getAllCards();
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  late double score;
  late bool allowBack;
  late bool isTextVis;
  late double width;
  late String scoreText;

  @override
  void initState() {
    super.initState();
    //emailController = TextEditingController()..addListener(controllerListener);
    //emailValid = false;
    //primaryButtonEnabled = false;
    
    
    score = (widget.correctAnswers / widget.questions) * 100;
    allowBack = false;
    isTextVis = false;
    scoreText = '';
    width = 250;
    //openRest();
  }


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
              Expanded(
                child: Center(
                  child: AnimatedContainer(
                    width: width,
                    height: width,
                    duration: Duration(seconds: 1),
                    child: CircularSeekBar(
                      width: double.infinity,
                      animDurationMillis: 3000,
                      height: 250,
                      progress: score,
                      barWidth: 12,
                      startAngle: 45,
                      sweepAngle: 270,
                      strokeCap: StrokeCap.butt,
                      progressGradientColors: const [
                        Colors.red,
                        Colors.red,
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.yellow,
                        Colors.green,
                        Colors.green,
                        Colors.green,
                        Colors.green,
                      ],
                      innerThumbRadius: 5,
                      trackColor: Colors.blueGrey.shade200,
                      innerThumbStrokeWidth: 3,
                      innerThumbColor: Colors.white,
                      outerThumbRadius: 5,
                      outerThumbStrokeWidth: 10,
                      outerThumbColor: Colors.blueAccent,
                      dashWidth: 1,
                      dashGap: 2,
                      animation: true,
                      curves: Curves.bounceInOut,
                      valueNotifier: _valueNotifier,
                      child: Center(
                        child: ValueListenableBuilder(
                          valueListenable: _valueNotifier,
                          builder: (_, double value, __) =>
                              Column(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  Text('${value.round()}'),
                                  Text('SCORE'),
                                ],
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}