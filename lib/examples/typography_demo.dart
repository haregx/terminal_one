import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../themes/platform_typography.dart';

/// Demo widget showing platform-aware typography styles
/// 
/// This demonstrates how text appears differently on iOS vs Android
/// following respective design guidelines
class TypographyDemo extends StatelessWidget {
  const TypographyDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isIOS = Platform.isIOS || Platform.isMacOS;
    final String platformName = isIOS ? 'iOS' : 'Android';
    final String fontFamily = PlatformTypography.primaryFontFamily;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('$platformName Typography'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Platform info card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform: $platformName',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Font Family: $fontFamily',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    'Guidelines: ${isIOS ? "Human Interface Guidelines" : "Material Design 3"}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Typography showcase
            _buildTypographySection(context, 'Display & Headlines', [
              _TypographyExample('Display Large', Theme.of(context).textTheme.displayLarge),
              _TypographyExample('Display Medium', Theme.of(context).textTheme.displayMedium),
              _TypographyExample('Headline Large', Theme.of(context).textTheme.headlineLarge),
              _TypographyExample('Headline Medium', Theme.of(context).textTheme.headlineMedium),
            ]),
            
            const SizedBox(height: 24),
            
            _buildTypographySection(context, 'Titles', [
              _TypographyExample('Title Large', Theme.of(context).textTheme.titleLarge),
              _TypographyExample('Title Medium', Theme.of(context).textTheme.titleMedium),
              _TypographyExample('Title Small', Theme.of(context).textTheme.titleSmall),
            ]),
            
            const SizedBox(height: 24),
            
            _buildTypographySection(context, 'Body Text', [
              _TypographyExample('Body Large', Theme.of(context).textTheme.bodyLarge),
              _TypographyExample('Body Medium', Theme.of(context).textTheme.bodyMedium),
              _TypographyExample('Body Small', Theme.of(context).textTheme.bodySmall),
            ]),
            
            const SizedBox(height: 24),
            
            _buildTypographySection(context, 'Labels', [
              _TypographyExample('Label Large', Theme.of(context).textTheme.labelLarge),
              _TypographyExample('Label Medium', Theme.of(context).textTheme.labelMedium),
              _TypographyExample('Label Small', Theme.of(context).textTheme.labelSmall),
            ]),
            
            const SizedBox(height: 24),
            
            // Platform comparison
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withAlpha(100),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform-spezifische Eigenschaften',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isIOS) ...[
                    _buildFeatureRow(context, '✓', 'San Francisco Font (.SF UI Text/Display)'),
                    _buildFeatureRow(context, '✓', 'iOS Typography Scale (11pt - 34pt)'),
                    _buildFeatureRow(context, '✓', 'Kompakte Zeilenhöhen (1.2 - 1.5)'),
                    _buildFeatureRow(context, '✓', 'Negative Letter Spacing für große Texte'),
                  ] else ...[
                    _buildFeatureRow(context, '✓', 'Roboto Font Family'),
                    _buildFeatureRow(context, '✓', 'Material Design 3 Type Scale'),
                    _buildFeatureRow(context, '✓', 'Großzügige Zeilenhöhen (1.25 - 1.55)'),
                    _buildFeatureRow(context, '✓', 'Positive Letter Spacing für Lesbarkeit'),
                  ],
                ],
              ),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographySection(BuildContext context, String title, List<_TypographyExample> examples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        ...examples.map((example) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                example.label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'The quick brown fox jumps over the lazy dog',
                style: example.textStyle,
              ),
              const SizedBox(height: 4),
              Text(
                'Font: ${example.textStyle?.fontFamily ?? "Default"} • '
                'Size: ${example.textStyle?.fontSize?.toStringAsFixed(1) ?? "0"}pt • '
                'Weight: ${_getFontWeightName(example.textStyle?.fontWeight)}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildFeatureRow(BuildContext context, String icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            icon,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _getFontWeightName(FontWeight? weight) {
    if (weight == null) return 'Regular';
    switch (weight.index) {
      case 1: return 'Thin';
      case 2: return 'ExtraLight';
      case 3: return 'Light';
      case 4: return 'Regular';
      case 5: return 'Medium';
      case 6: return 'SemiBold';
      case 7: return 'Bold';
      case 8: return 'ExtraBold';
      case 9: return 'Black';
      default: return 'Regular';
    }
  }
}

class _TypographyExample {
  final String label;
  final TextStyle? textStyle;

  _TypographyExample(this.label, this.textStyle);
}