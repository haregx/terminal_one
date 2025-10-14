import 'dart:async';
import 'package:flutter/material.dart';

class ClassicCircularProgressController {
  VoidCallback? _onStart;
  VoidCallback? _onPause;
  VoidCallback? _onResume;
  VoidCallback? _onRestart;
  VoidCallback? _onStop;

  void _bind({
    required VoidCallback onStart,
    required VoidCallback onPause,
    required VoidCallback onResume,
    required VoidCallback onRestart,
    required VoidCallback onStop,
  }) {
    _onStart = onStart;
    _onPause = onPause;
    _onResume = onResume;
    _onRestart = onRestart;
    _onStop = onStop;
  }

  void start() => _onStart?.call();
  void pause() => _onPause?.call();
  void resume() => _onResume?.call();
  void restart() => _onRestart?.call();
  void stop() => _onStop?.call();
}


class ClassicCircularProgress extends StatefulWidget {
  final int startSeconds;
  final double size;
  final Color color;
  final Color backgroundColor;
  final Color innerBackgroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onComplete;
  final ClassicCircularProgressController? controller;

  const ClassicCircularProgress({
    super.key,
    required this.startSeconds,
    this.size = 36, // <-- Default kleiner gemacht
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.innerBackgroundColor = Colors.green,
    this.textStyle,
    this.onComplete,
    this.controller,
  });

  @override
  State<ClassicCircularProgress> createState() => _ClassicCircularProgressState();
}

class _ClassicCircularProgressState extends State<ClassicCircularProgress> {
  late int secondsLeft;
  Timer? _timer;
  bool _isPaused = false;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    secondsLeft = widget.startSeconds;
    widget.controller?._bind(
      onStart: start,
      onPause: pause,
      onResume: resume,
      onRestart: restart,
      onStop: stop,
    );
  }

  void start() {
    if (_isStarted) return;
    setState(() {
      if (secondsLeft == 0) {
        secondsLeft = widget.startSeconds;
      }
      _isStarted = true;
      _isPaused = false;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (secondsLeft > 0) {
          setState(() {
            secondsLeft--;
          });
        } else {
          timer.cancel();
          _isStarted = false;
          if (widget.onComplete != null) widget.onComplete!();
        }
      }
    });
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    if (!_isStarted) return;
    _isPaused = false;
  }

  void restart() {
    setState(() {
      secondsLeft = widget.startSeconds;
      _isPaused = false;
      _isStarted = true;
    });
    _startTimer();
  }

  void stop() {
    _timer?.cancel();
    _isStarted = false;
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color innerColor;

    if (secondsLeft <= 5) {
      innerColor = Colors.red;
    } else if (secondsLeft <= 10) {
      // Übergang von gelb zu rot
      double t = (10 - secondsLeft) / 5;
      innerColor = Color.lerp(Colors.yellow, Colors.red, t)!;
    } else if (secondsLeft <= 20) {
      // Übergang von grün zu gelb (z.B. ab 20 Sekunden)
      double t = (20 - secondsLeft) / 10;
      innerColor = Color.lerp(Colors.green, Colors.yellow, t)!;
    } else if (secondsLeft <= widget.startSeconds) {
      // Startfarbe (grün)
      innerColor = Colors.green;
    } else {
      innerColor = widget.innerBackgroundColor;
    }

    Color textColor = Colors.white;

    double progress = secondsLeft / widget.startSeconds;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: innerColor,
              shape: BoxShape.circle,
            ),
          ),
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 5,
            backgroundColor: widget.backgroundColor,
            color: widget.color,
          ),
          Text(
            '$secondsLeft',
            style: (widget.textStyle ??
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )).copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}