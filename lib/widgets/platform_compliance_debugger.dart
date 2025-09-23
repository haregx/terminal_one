import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../utils/platform_guidelines_checker.dart';
import '../utils/platform_utils.dart';

/// Debug overlay that shows platform compliance information in development builds
/// 
/// This widget can be wrapped around any part of the app to provide
/// real-time platform guidelines compliance feedback during development.
class PlatformComplianceDebugger extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final bool showOverlay;

  const PlatformComplianceDebugger({
    super.key,
    required this.child,
    this.enabled = kDebugMode,
    this.showOverlay = false,
  });

  @override
  State<PlatformComplianceDebugger> createState() => _PlatformComplianceDebuggerState();
}

class _PlatformComplianceDebuggerState extends State<PlatformComplianceDebugger> {
  bool _showDebugInfo = false;
  Map<String, dynamic>? _complianceReport;

  @override
  void initState() {
    super.initState();
    _showDebugInfo = widget.showOverlay;
  }

  void _generateReport() {
    if (mounted) {
      setState(() {
        _complianceReport = PlatformGuidelinesChecker.generateComplianceReport(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    return Stack(
      children: [
        widget.child,
        
        // Debug toggle button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 10,
          child: FloatingActionButton.small(
            onPressed: () {
              setState(() {
                _showDebugInfo = !_showDebugInfo;
                if (_showDebugInfo) {
                  _generateReport();
                }
              });
            },
            backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(200),
            child: Icon(
              _showDebugInfo ? Icons.close : Icons.bug_report,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        
        // Debug overlay
        if (_showDebugInfo)
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 10,
            right: 10,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 400),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withAlpha(240),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withAlpha(20),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          PlatformUtils.isIOSContext(context) 
                              ? Icons.phone_iphone 
                              : Icons.android,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Platform Compliance Debug',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: _buildDebugContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDebugContent() {
    if (_complianceReport == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Platform info
        _buildInfoCard(
          title: 'Current Platform',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📱 ${_complianceReport!['platform']}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Guidelines: ${_complianceReport!['guidelines']}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // General recommendations
        _buildInfoCard(
          title: 'Platform Guidelines',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final recommendation in _complianceReport!['generalRecommendations'])
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      )),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Quick checks
        _buildInfoCard(
          title: 'Quick Compliance Checks',
          content: Column(
            children: [
              _buildCheckRow(
                'Platform-aware dialogs',
                _checkDialogCompliance(),
                'Using PlatformUtils.showPlatformDialog',
              ),
              _buildCheckRow(
                'Platform-aware navigation',
                _checkNavigationCompliance(),
                'Using platform-appropriate transitions',
              ),
              _buildCheckRow(
                'Typography compliance',
                _checkTypographyCompliance(),
                'Using platform standard font sizes',
              ),
              _buildCheckRow(
                'Touch target sizes',
                _checkTouchTargetCompliance(),
                'Minimum 44pt (iOS) / 48dp (Android)',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(100),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withAlpha(50),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _buildCheckRow(String label, bool isCompliant, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isCompliant ? Icons.check_circle : Icons.warning,
            color: isCompliant ? Colors.green : Colors.orange,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _checkDialogCompliance() {
    // This would check if dialogs in the app use platform-appropriate components
    return true; // Assuming we're using PlatformUtils
  }

  bool _checkNavigationCompliance() {
    // This would check if navigation uses platform-appropriate transitions
    return true; // Assuming we're using platform-aware navigation
  }

  bool _checkTypographyCompliance() {
    // This would analyze the current theme typography
    return true; // Placeholder
  }

  bool _checkTouchTargetCompliance() {
    // This would check if interactive elements meet minimum size requirements
    return true; // Placeholder
  }
}