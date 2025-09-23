import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/platform_utils.dart';

/// Platform-aware button with icon support that automatically uses the appropriate
/// design language for iOS (CupertinoButton) and Android (ElevatedButton)
class PlatformButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final bool isDestructive;
  final bool isSecondary;
  final IconData? icon;
  final bool iconOnly;

  const PlatformButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.isDestructive = false,
    this.isSecondary = false,
    this.icon,
    this.iconOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonChild;
    
    if (icon != null) {
      if (iconOnly) {
        buttonChild = Icon(
          icon,
          size: PlatformUtils.isIOSContext(context) ? 22.0 : 20.0,
        );
      } else {
        buttonChild = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: PlatformUtils.isIOSContext(context) ? 18.0 : 16.0,
            ),
            const SizedBox(width: 8.0),
            child,
          ],
        );
      }
    } else {
      buttonChild = child;
    }

    if (PlatformUtils.isIOSContext(context)) {
      return CupertinoButton(
        onPressed: onPressed,
        color: isSecondary ? null : (backgroundColor ?? CupertinoColors.activeBlue),
        padding: padding ?? EdgeInsets.symmetric(
          horizontal: iconOnly ? 12.0 : 16.0,
          vertical: iconOnly ? 12.0 : 12.0,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: isSecondary 
                ? (isDestructive ? CupertinoColors.destructiveRed : CupertinoColors.activeBlue)
                : (foregroundColor ?? CupertinoColors.white),
            fontSize: 17.0, // iOS standard button font size
            fontWeight: FontWeight.w400,
          ),
          child: buttonChild,
        ),
      );
    } else {
      if (iconOnly) {
        return IconButton(
          onPressed: onPressed,
          icon: buttonChild,
          color: isDestructive 
              ? Theme.of(context).colorScheme.error 
              : (foregroundColor ?? Theme.of(context).colorScheme.primary),
        );
      } else if (isSecondary) {
        return icon != null 
            ? TextButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: child,
                style: TextButton.styleFrom(
                  foregroundColor: isDestructive 
                      ? Theme.of(context).colorScheme.error 
                      : (foregroundColor ?? Theme.of(context).colorScheme.primary),
                  padding: padding,
                ),
              )
            : TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  foregroundColor: isDestructive 
                      ? Theme.of(context).colorScheme.error 
                      : (foregroundColor ?? Theme.of(context).colorScheme.primary),
                  padding: padding,
                ),
                child: child,
              );
      } else {
        return icon != null 
            ? ElevatedButton.icon(
                onPressed: onPressed,
                icon: Icon(icon),
                label: child,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
                  foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
                  padding: padding,
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
                  foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
                  padding: padding,
                ),
                child: child,
              );
      }
    }
  }
}

/// Platform-aware icon button following design guidelines
class PlatformIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  final String? tooltip;
  final bool isDestructive;

  const PlatformIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
    this.tooltip,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? (PlatformUtils.isIOSContext(context) ? 22.0 : 24.0);
    final iconColor = color ?? (isDestructive 
        ? (PlatformUtils.isIOSContext(context) 
            ? CupertinoColors.destructiveRed 
            : Theme.of(context).colorScheme.error)
        : (PlatformUtils.isIOSContext(context) 
            ? CupertinoColors.activeBlue 
            : Theme.of(context).colorScheme.primary));

    if (PlatformUtils.isIOSContext(context)) {
      return CupertinoButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(8.0),
        minimumSize: const Size(44.0, 44.0), // iOS minimum touch target
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      );
    } else {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: iconSize,
        color: iconColor,
        tooltip: tooltip,
        constraints: const BoxConstraints(
          minWidth: 48.0, // Material minimum touch target
          minHeight: 48.0,
        ),
      );
    }
  }
}

/// Platform-aware text input field
class PlatformTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final int? maxLines;
  final bool autofocus;
  final EdgeInsetsGeometry? padding;

  const PlatformTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.maxLines = 1,
    this.autofocus = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOSContext(context)) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CupertinoTextField(
          controller: controller,
          placeholder: placeholder ?? labelText,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          maxLines: maxLines,
          autofocus: autofocus,
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.resolveFrom(context),
            border: Border.all(
              color: CupertinoColors.systemGrey4.resolveFrom(context),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        ),
      );
    } else {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: placeholder,
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          maxLines: maxLines,
          autofocus: autofocus,
        ),
      );
    }
  }
}

/// Platform-aware list tile
class PlatformListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  const PlatformListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  });

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOSContext(context)) {
      return CupertinoListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing ?? (showChevron && onTap != null 
            ? const Icon(LucideIcons.chevronRight, size: 16.0)
            : null),
        onTap: onTap,
      );
    } else {
      return ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing ?? (showChevron && onTap != null 
            ? const Icon(LucideIcons.chevronRight)
            : null),
        onTap: onTap,
      );
    }
  }
}

/// Platform-aware scaffold with appropriate navigation bar
class PlatformScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;
  final Widget? floatingActionButton;

  const PlatformScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    if (PlatformUtils.isIOSContext(context)) {
      return CupertinoPageScaffold(
        backgroundColor: backgroundColor ?? CupertinoColors.systemBackground.resolveFrom(context),
        navigationBar: title != null ? CupertinoNavigationBar(
          middle: Text(title!),
          leading: leading,
          trailing: actions != null && actions!.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                )
              : null,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ) : null,
        child: body,
      );
    } else {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: title != null ? AppBar(
          title: Text(title!),
          actions: actions,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ) : null,
        body: body,
        floatingActionButton: floatingActionButton,
      );
    }
  }
}