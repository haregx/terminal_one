import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';
import '../widgets/platform_widgets.dart';

/// Base mixin for platform-compliant screens
mixin PlatformScreenMixin<T extends StatefulWidget> on State<T> {
  
  /// Get platform-appropriate spacing
  double getPlatformSpacing(BuildContext context) {
    return 16.0; // Standard spacing for both platforms
  }
  
  /// Get platform-appropriate text style
  TextStyle getPlatformTextStyle(BuildContext context, {
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return PlatformUtils.isIOSContext(context)
        ? CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
          )
        : Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
          );
  }
  
  /// Navigate to screen with platform-appropriate transition
  void navigateToPlatformScreen(BuildContext context, Widget screen) {
    if (PlatformUtils.isIOSContext(context)) {
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => screen),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }
  
  /// Show platform-appropriate dialog
  Future<void> showPlatformDialog(
    BuildContext context, {
    required String title,
    required String content,
    List<PlatformDialogAction> actions = const [],
  }) {
    return PlatformUtils.showPlatformDialog(
      context: context,
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
  
  /// Show platform-appropriate message
  void showPlatformMessage(BuildContext context, String message) {
    if (PlatformUtils.isIOSContext(context)) {
      showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
  
  /// Build platform-appropriate scaffold
  Widget buildPlatformScaffold({
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    Color? backgroundColor,
    required Widget body,
    Widget? floatingActionButton,
  }) {
    return PlatformUtils.isIOSContext(context)
        ? CupertinoPageScaffold(
            navigationBar: title != null 
                ? CupertinoNavigationBar(
                    leading: leading,
                    automaticallyImplyLeading: automaticallyImplyLeading,
                    middle: Text(title),
                    trailing: actions?.isNotEmpty == true 
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!,
                          )
                        : null,
                  )
                : null,
            backgroundColor: backgroundColor,
            child: SafeArea(child: body),
          )
        : Scaffold(
            appBar: title != null 
                ? AppBar(
                    title: Text(title),
                    actions: actions,
                    leading: leading,
                    automaticallyImplyLeading: automaticallyImplyLeading,
                  )
                : null,
            backgroundColor: backgroundColor,
            body: SafeArea(child: body),
            floatingActionButton: floatingActionButton,
          );
  }

  /// Build section header ohne doppelte Unterstreichung
  Widget buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.0, // Links
        24.0, // Oben - mehr Abstand
        16.0, // Rechts
        8.0,  // Unten - weniger Abstand
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
  
  /// Build platform list tile
  Widget buildPlatformListTile({
    Widget? leading,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return PlatformListTile(
      leading: leading,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}