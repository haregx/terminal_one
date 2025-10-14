import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuizButtonFlippable extends StatefulWidget {
  final bool isClickable;
  final bool isClicked;
  final String text;
  final double size;
  final Color? frontColor;
  final Color? flippedColor;
  final TextStyle? textStyle;
  final bool isCorrect;
  final bool isFlipped;
  final VoidCallback onPressed;

  const QuizButtonFlippable({
    super.key,
    required this.text,
    this.size = 177.0,
    this.frontColor,
    this.flippedColor,
    this.textStyle,
    required this.isCorrect,
    this.isFlipped = false,
    required this.onPressed,
    this.isClicked = false,
    this.isClickable = true,
  });

  @override
  State<QuizButtonFlippable> createState() => _QuizButtonFlippableState();
}

class _QuizButtonFlippableState extends State<QuizButtonFlippable> with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant QuizButtonFlippable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isClicked != oldWidget.isClicked) {
      setState(() {
        isClicked = widget.isClicked;
      });
    }
    if (widget.isFlipped != oldWidget.isFlipped) {
      if (widget.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      _flipped = widget.isFlipped;
    }
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _flipped = false;
  late bool isClicked;

  @override
  void initState() {
    isClicked = widget.isClicked;
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onPressed();
    if (_flipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _flipped = !_flipped;
      isClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final bool isIOS = platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    final Color frontColor = widget.frontColor ?? (isIOS ? const Color(0xFF007AFF) : Theme.of(context).colorScheme.primary);
    final Color flippedColor = widget.flippedColor ?? Colors.green;
    final bool clickable = widget.isClickable && !isClicked;

    // Helles Rot für nicht geklickte, falsche Antwort
    final Color lightRed = const Color(0xFFFFB3B3);

  /*  final Color color = _flipped
        ? (widget.isCorrect
            ? flippedColor
            : isClicked
                ? Colors.red
                : lightRed)
        : frontColor;
        */

    return MouseRegion(
      cursor: clickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: clickable ? _handleTap : null,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final angle = _animation.value;
            final isZenit = angle > math.pi / 2;
            final Color displayColor = isZenit
                ? (widget.isCorrect
                    ? flippedColor
                    : isClicked
                        ? Colors.red
                        : lightRed)
                : frontColor;

            // Text immer richtig herum anzeigen
            final double displayAngle = angle > math.pi / 2 ? math.pi - angle : angle;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(displayAngle),
              child: ConstrainedBox(constraints: BoxConstraints(minHeight: widget.size * 12 / 16, maxHeight: widget.size *  12 / 16),
                child: Container(
                  width: math.min(widget.size, MediaQuery.of( context).size.width/2 - 24),
               //   height: widget.size * 12 / 16, // Höhe ist jetzt im Verhältnis 16:10 zur Breite
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.75,
                    colors: [
                      displayColor.withAlpha(250),
                      displayColor,
                      darken(displayColor, 0.18),
                    ],
                    stops: const [0.0, 0.25, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      offset: const Offset(8, 8),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.text,
                    style: (widget.textStyle ??
                        TextStyle(
                          fontSize: _getFontSize(widget.text),
                          fontWeight: FontWeight.bold,
                        )).copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
            );
          },
        ),
      ),
    );
  }

  // Hilfsfunktion zum Abdunkeln einer Farbe
  Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  double _getFontSize(String text) {
    final int length = text.length;
    if (length <= 25) return 18;
    if (length <= 40) return 17;
    if (length <= 60) return 16;
    return 14; // Für sehr lange Texte
  }
}
