import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';
import '../widgets/platform_widgets.dart';

/// Base mixin for all app screens ensuring platform guidelines compliance
mixin PlatformBaseScreenMixin<T extends StatefulWidget> on State<T> {
  
  /// Get platform-appropriate spacing
  double getPlatformSpacing(BuildContext context) {
    return PlatformUtils.isIOSContext(context) ? 16.0 : 16.0;
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
  
  /// Show platform-appropriate message (toast/banner)
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
}

/// Mixin for forms with platform-specific validation and styling
mixin PlatformFormMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  /// Validate form with platform-appropriate feedback
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bitte überprüfen Sie Ihre Eingaben')),
    );
    return false;
  }
  
  /// Save form data
  void saveForm() {
    formKey.currentState?.save();
  }
}

/// Mixin for lists with platform-specific styling
mixin PlatformListMixin<T extends StatefulWidget> on State<T> {
  
  /// Build platform-appropriate section header
  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  /// Build platform-appropriate list tile
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

/// Mixin for screens with loading states
mixin PlatformLoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;
  
  /// Show platform-appropriate loading indicator
  void setLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }
  
  /// Build loading overlay
  Widget buildLoadingOverlay({Widget? child}) {
    if (!_isLoading) return child ?? const SizedBox.shrink();
    
    return Stack(
      children: [
        if (child != null) child,
        Container(
          color: Colors.black.withAlpha(77), // 0.3 * 255 = 76.5 ≈ 77
          child: Center(
            child: PlatformUtils.isIOSContext(context)
                ? const CupertinoActivityIndicator(radius: 15)
                : const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}