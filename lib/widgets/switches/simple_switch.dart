import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';

/// A simple adaptive switch that uses Material Switch on Android and CupertinoSwitch on iOS.
class SimpleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;


  const SimpleSwitch({
    super.key,
    required this.value,
    required this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    //final platform = Theme.of(context).platform;
    //if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
    //  return CupertinoSwitch(
    //    value: value,
    //    onChanged: onChanged,
    //  );
    //} else {
      return Switch.adaptive(
        value: value,
        onChanged: onChanged,
      );
   // }
  }
}
