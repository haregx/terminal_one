import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

/// Centralized platform detection and UI component selection
/// 
/// This utility ensures consistent platform-appropriate UI components
/// across the entire app, following iOS Human Interface Guidelines
/// and Android Material Design Guidelines automatically.
class PlatformUtils {
  PlatformUtils._(); // Private constructor to prevent instantiation

  /// Detect if running on iOS/macOS
  static bool get isIOS {
    return Platform.isIOS || Platform.isMacOS;
  }

  /// Detect if running on Android
  static bool get isAndroid {
    return Platform.isAndroid;
  }

  /// Get platform-appropriate theme data
  static bool isIOSContext(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  /// Show platform-appropriate dialog
  static Future<T?> showPlatformDialog<T>({
    required BuildContext context,
    required Widget title,
    required Widget content,
    required List<PlatformDialogAction> actions,
    bool barrierDismissible = true,
  }) {
    if (isIOSContext(context)) {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions.map((action) => CupertinoDialogAction(
            isDefaultAction: action.isDefault,
            isDestructiveAction: action.isDestructive,
            onPressed: action.onPressed,
            child: action.child,
          )).toList(),
        ),
      );
    } else {
      return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
          title: title,
          content: content,
          actions: actions.map((action) => TextButton(
            onPressed: action.onPressed,
            child: action.child,
          )).toList(),
        ),
      );
    }
  }

  /// Show platform-appropriate action sheet
  static Future<T?> showPlatformActionSheet<T>({
    required BuildContext context,
    required Widget title,
    Widget? message,
    required List<PlatformSheetAction<T>> actions,
    PlatformSheetAction<T>? cancelAction,
  }) {
    if (isIOSContext(context)) {
      return showCupertinoModalPopup<T>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: title,
          message: message,
          actions: actions.map((action) => CupertinoActionSheetAction(
            isDefaultAction: action.isDefault,
            isDestructiveAction: action.isDestructive,
            onPressed: () {
              Navigator.pop(context, action.value);
            },
            child: action.child,
          )).toList(),
          cancelButton: cancelAction != null
              ? CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context, cancelAction.value);
                  },
                  child: cancelAction.child,
                )
              : null,
        ),
      );
    } else {
      return showModalBottomSheet<T>(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleLarge!,
                child: title,
              ),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!,
                  child: message,
                ),
              ),
            ...actions.map((action) => ListTile(
              title: action.child,
              onTap: () {
                Navigator.pop(context, action.value);
              },
            )),
            if (cancelAction != null)
              ListTile(
                title: cancelAction.child,
                onTap: () {
                  Navigator.pop(context, cancelAction.value);
                },
              ),
          ],
        ),
      );
    }
  }

  /// Get platform-appropriate loading indicator
  static Widget getPlatformLoadingIndicator({
    Color? color,
    double? strokeWidth,
  }) {
    if (isIOS) {
      return CupertinoActivityIndicator(
        color: color,
      );
    } else {
      return CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth ?? 4.0,
      );
    }
  }

  /// Get platform-appropriate switch
  static Widget getPlatformSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? activeColor,
  }) {
    if (isIOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: activeColor,
        activeThumbColor: activeColor,
      );
    }
  }

  /// Get platform-appropriate navigation transition
  static PageRouteBuilder<T> getPlatformRoute<T>({
    required Widget page,
    RouteSettings? settings,
  }) {
    if (isIOS) {
      return PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        },
      );
    } else {
      return PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    }
  }
}

/// Platform-agnostic dialog action
class PlatformDialogAction {
  final Widget child;
  final VoidCallback? onPressed;
  final bool isDefault;
  final bool isDestructive;

  const PlatformDialogAction({
    required this.child,
    this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
  });
}

/// Platform-agnostic action sheet action
class PlatformSheetAction<T> {
  final Widget child;
  final T value;
  final bool isDefault;
  final bool isDestructive;

  const PlatformSheetAction({
    required this.child,
    required this.value,
    this.isDefault = false,
    this.isDestructive = false,
  });
}