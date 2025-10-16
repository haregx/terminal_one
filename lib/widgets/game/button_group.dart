import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:terminal_one/widgets/buttons/button3d.dart';
import 'package:terminal_one/widgets/buttons/ghost_button.dart';
import 'package:terminal_one/widgets/game/button_flippable.dart';
import 'package:terminal_one/widgets/game/circular_progress.dart';
import 'package:terminal_one/widgets/game/dots_progress_group.dart';

class QuizButtonsGroup extends StatefulWidget {
  final Map<int, List<dynamic>> map;
  final Function(bool) callbackNextStep;
  final Function(int) callbackNextPage;
  final VoidCallback callbackQuestionClicked;
  final Function(String, String, bool) callbackExplanationClicked;
  final int sumQuestions;
  final String categoryName;

  const QuizButtonsGroup({
    super.key,
    required this.callbackNextStep,
    required this.callbackNextPage,
    required this.callbackQuestionClicked,
    required this.categoryName, 
    required this.map,
    required this.sumQuestions, 
    required this.callbackExplanationClicked,
  });

  @override
  State<QuizButtonsGroup> createState() => _QuizButtonsGroupState();
  
  

}

class _QuizButtonsGroupState extends State<QuizButtonsGroup> {

  int currentIndex = 0;
  Map<int, List<dynamic>> get map => widget.map;
  String get question => map[currentIndex]![1]; 
  List<bool> get isCorrectList => [map[currentIndex]![2] == 1, map[currentIndex]![2] == 2, map[currentIndex]![2] == 3, map[currentIndex]![2] == 4];
  List<String> get answerList => [map[currentIndex]![3], map[currentIndex]![4], map[currentIndex]![5], map[currentIndex]![6]];
  String get explanation => map[currentIndex]![9];
  bool get hasKI => map[currentIndex]![8] == true;
  List<bool> isFlippedList = [false, false, false, false];
  List<bool> isClickedList = [false, false, false, false];
  List<bool> isClickableList = [true, true, true, true];
  late List<int> statusList = List.filled(widget.sumQuestions, -1);
  final ClassicCircularProgressController _controller = ClassicCircularProgressController();
  int _startSeconds = 60;

  bool showNextStepButton = false;
  bool isLastQuestion = false;
  int correctAnswersCount = 0;

  late int currentTimerVal = 0;

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.start();
      _startSeconds = kDebugMode ? 10 : _startSeconds;
    });
  }

  void _onQuizButtonPressed(int index, {bool isTimeout = false}) {
    _controller.pause();
    setState(() {
      isFlippedList = [true, true, true, true];
      isClickedList = [false, false, false, false];
      isClickedList[index] = true;
      isClickableList = [false, false, false, false];
      statusList[currentIndex] = isTimeout
          ? 3 // 3 steht für Timeout
          : (isCorrectList[index] ? 1 : 2);
      if (isCorrectList[index] && !isTimeout) correctAnswersCount++;
      isLastQuestion = currentIndex == widget.sumQuestions - 1;
    });
    // Timeout: Antwort als falsch melden
    widget.callbackQuestionClicked.call();
    if (isTimeout) {
      widget.callbackNextStep(false); // <-- Antwort als falsch melden!
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('quiz.time_is_up'.tr(namedArgs: {'seconds': '$_startSeconds'}))),
          duration: Duration(seconds: 3),
        ),
      );
    }
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showNextStepButton = true;
        });
      }
    });
    
  }

    

  void _onShowResultPressed() {
    
    setState(() {
      widget.callbackNextPage(correctAnswersCount);
    });
  }

  void _onNextQuestionPressed() {
    setState(() {
      !isLastQuestion ? 
      {
        showNextStepButton = false,
        isFlippedList = [false, false, false, false],
        isClickedList = [false, false, false, false],
        isClickableList = [true, true, true, true],

        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            setState(() {
              currentIndex++;
            });
          }
        }),
        _controller.restart(),
      }
      : null;// widget.callbackNextPage(correctAnswers);
      widget.callbackNextStep(isLastQuestion);
    });
  }

  double _getQuestionFontSize(String text) {
    final int length = text.length;
    if (length <= 60) return 18;
    if (length <= 80) return 17;
    if (length <= 100) return 16;
    return 14;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
          children: [
            DotsProgressGroup(
              totalDots: statusList.length,
              activeDot: currentIndex,
                statusList: statusList,
              ),
              SizedBox(height:8),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 140, maxHeight: 140, maxWidth: 500),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(13),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Kategorie-Box links oben positionieren
                    Positioned(
                      top: -28,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.categoryName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    // Timer oben rechts positionieren
                    Positioned(
                      top: -30,
                      right: 0,
                      child: ClassicCircularProgress(
                        controller: _controller,
                        startSeconds: kDebugMode ? 10 : _startSeconds,
                        onComplete: () {
                          final correctIndex = isCorrectList.indexOf(true);
                          if (correctIndex != -1) {
                            _onQuizButtonPressed(correctIndex, isTimeout: true);
                          }
                        },
                      ),
                    ),
                    // Frage-Text mittig
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          question,
                          maxLines: 5,
                          style: TextStyle(
                            fontSize: _getQuestionFontSize(question),
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withAlpha(180),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      QuizButtonFlippable(
                        text: answerList[0],
                        isFlipped: isFlippedList[0],
                        isClickable: isClickableList[0],
                        isClicked: isClickedList[0],
                        isCorrect: isCorrectList[0],
                        onPressed: () => _onQuizButtonPressed(0),
                      ),

                      QuizButtonFlippable(
                        text: answerList[1],
                        isFlipped: isFlippedList[1],
                        isClickable: isClickableList[1],
                        isClicked: isClickedList[1],
                        isCorrect: isCorrectList[1],
                        onPressed: () => _onQuizButtonPressed(1),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      QuizButtonFlippable(
                        text: answerList[2],
                        isFlipped: isFlippedList[2],
                        isClickable: isClickableList[2],
                        isClicked: isClickedList[2],
                        isCorrect: isCorrectList[2],
                        onPressed: () => _onQuizButtonPressed(2),
                      ),
                      QuizButtonFlippable(
                        text: answerList[3],
                        isFlipped: isFlippedList[3],
                        isClicked: isClickedList[3],
                        isClickable: isClickableList[3],
                        isCorrect: isCorrectList[3],
                        onPressed: () => _onQuizButtonPressed(3),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
          ],
          
        ),
        Column(
          children: [
            showNextStepButton 
            ? AnimatedOpacity(
              opacity: showNextStepButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: IgnorePointer(
                ignoring: !showNextStepButton,
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    explanation.isEmpty 
                      ? SizedBox(height: 44,) 
                      : GhostButton(
                          leading: LucideIcons.info,
                          label: 'quiz.explanation_button'.tr(),
                          onPressed: () {
                            debugPrint ('Warum? Button geklickt, Erklärung: $explanation');
                            widget.callbackExplanationClicked(question, explanation, hasKI);
                          },
                        ),
                    IntrinsicWidth(
                      child: Button3D(
                        leadingIcon: LucideIcons.stepForward,
                        label: isLastQuestion ? 'quiz.to_results'.tr() : 'quiz.next_question'.tr(),
                        onPressed: !isLastQuestion ? _onNextQuestionPressed : _onShowResultPressed,
                        enabled: true,
                      ),
                    ),
                  ],
                ),
              ),
            )
            : SizedBox(height: 104,),
          ],
        )
      ] 
    );
  }
  

}
