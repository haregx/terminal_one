import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PrivacySwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;
  final VoidCallback? onLabelTap;

  const PrivacySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'I accept the privacy policy',
    this.onLabelTap,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS || Theme.of(context).platform == TargetPlatform.macOS;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isIOS
            ? CupertinoSwitch(
                value: value,
                onChanged: onChanged,
              )
            : Switch(
                value: value,
                onChanged: onChanged,
              ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onLabelTap,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: onLabelTap != null ? TextDecoration.underline : null,
                color: onLabelTap != null ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
