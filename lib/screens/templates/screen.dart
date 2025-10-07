import 'package:flutter/material.dart';

class ResponsiveBackgroundTemplate extends StatefulWidget {
  final Widget? child;
  final String? title;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;

  const ResponsiveBackgroundTemplate({
    super.key,
    this.child,
    this.title,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
  });

  @override
  State<ResponsiveBackgroundTemplate> createState() => _ResponsiveBackgroundTemplateState();
}

class _ResponsiveBackgroundTemplateState extends State<ResponsiveBackgroundTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? (widget.title != null ? AppBar(
        title: Text(widget.title!),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ) : null),
      extendBodyBehindAppBar: true,
      drawer: widget.drawer,
      endDrawer: widget.endDrawer,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/background/spanish.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3) // Reduziert für sichtbares Hintergrundbild
                : Colors.white.withOpacity(0.05),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: SafeArea(
          child: widget.child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class ResponsiveScreenTemplate extends StatelessWidget {
  final Widget? child;
  final String? title;
  final bool showAppBar;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final EdgeInsetsGeometry? padding;
  final bool extendBodyBehindAppBar;
  final Color? overlayColor;
  final double? overlayOpacity;
  final bool enableScrolling;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;

  const ResponsiveScreenTemplate({
    super.key,
    this.child,
    this.title,
    this.showAppBar = true,
    this.actions,
    this.leading,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.padding,
    this.extendBodyBehindAppBar = true,
    this.overlayColor,
    this.overlayOpacity,
    this.enableScrolling = true,
    this.scrollPhysics,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    final isDesktop = screenSize.width > 1200;
    
    return Scaffold(
      appBar: showAppBar ? AppBar(
        title: title != null ? Text(title!) : null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        actions: actions,
        leading: leading,
        centerTitle: !isDesktop,
      ) : null,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/background/spanish.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3) // Reduziert für sichtbares Hintergrundbild
                : Colors.white.withOpacity(0.05),
              BlendMode.srcOver,
            ),
          ),
        ),
        child: overlayColor != null ? Container(
          color: overlayColor!.withOpacity(overlayOpacity ?? 0.3),
          child: _buildContent(context, isTablet, isDesktop),
        ) : _buildContent(context, isTablet, isDesktop),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isTablet, bool isDesktop) {
    Widget content = child ?? const SizedBox.shrink();
    
    EdgeInsetsGeometry responsivePadding;
    if (padding != null) {
      responsivePadding = padding!;
    } else {
      if (isDesktop) {
        responsivePadding = const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0);
      } else if (isTablet) {
        responsivePadding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0);
      } else {
        responsivePadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
      }
    }
    
    if (enableScrolling) {
      content = SingleChildScrollView(
        controller: scrollController,
        physics: scrollPhysics ?? const BouncingScrollPhysics(),
        padding: responsivePadding,
        child: content,
      );
      
      return SafeArea(child: content);
    } else {
      content = Padding(
        padding: responsivePadding,
        child: content,
      );
      
      return SafeArea(child: content);
    }
  }
}
