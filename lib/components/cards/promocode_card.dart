import 'package:flutter/material.dart';

class PromoCodeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String promoCode;
  final String validity;
  final void Function() onTap;

  const PromoCodeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.promoCode,
    required this.validity,
    required this.onTap, 
    required String rowGuid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.onSurface.withAlpha(30)
            : Theme.of(context).cardColor,
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                // Bild mit Gradient und Halbkreis für Gültigkeit
                SizedBox(
                  width: 168,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            final isDark = Theme.of(context).brightness == Brightness.dark;
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 0.5, 0.75, 1.0],
                              colors: [
                                Colors.transparent,
                                isDark
                                  ? Theme.of(context).colorScheme.surface.withAlpha(30)
                                  : Theme.of(context).cardColor.withAlpha(6),
                                isDark
                                  ? Theme.of(context).colorScheme.surface.withAlpha(127)
                                  : Theme.of(context).cardColor.withAlpha(127),
                                isDark
                                  ? Theme.of(context).colorScheme.surface
                                  : Theme.of(context).cardColor,
                              ],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.srcOver,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Roter Vollkreis mit Restzeit, links unten, Text optimal positioniert
                      Positioned(
                        left: -30,
                        bottom: -40,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness == Brightness.dark
                                    ? Colors.deepOrange
                                    : Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Align(
                                alignment: const Alignment(0.2, -0.4),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nur noch',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '3 Std.', // Beispielwert, kann dynamisch werden
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Textbereich
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                        Text(description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).colorScheme.surface
                                : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              promoCode,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                letterSpacing: 2,
                                color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Center(child: Text('Gültigkeit: $validity', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
