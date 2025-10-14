import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DotsProgressGroup extends StatefulWidget {
  /// Creates a progress indicator with dots.
  final int totalDots;
  int activeDot;
  double dotSize;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  List<int> statusList;

  DotsProgressGroup({
    super.key,
    required this.totalDots,
    required this.activeDot,
    this.dotSize = 12,
    this.spacing = 8,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    required List<int>? statusList,
  }) : statusList = statusList ?? [];

  @override
  State<DotsProgressGroup> createState() => _DotsProgressGroupState();
}

class _DotsProgressGroupState extends State<DotsProgressGroup> {

  late double currentDotSize;

  Color _getDotColor(int index) {
    switch (widget.statusList[index]) {
      case 0:
        return widget.activeColor;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      case 3:
        return Colors.orange; // Status 3 = orange (z.B. Timeout)
      case -1:
      default:
        return widget.activeColor.withAlpha(127);
    }
  }

  @override
  void initState() {
    super.initState();
    currentDotSize = widget.dotSize;


  }
    
    

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.totalDots, (index) {
        currentDotSize = index == widget.activeDot ? 18 : widget.dotSize; // <--- size 15 für activeDot
        return Container(
          width: currentDotSize,
          height: currentDotSize,
          margin: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          decoration: BoxDecoration(
            color: _getDotColor(index),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}