import 'package:flutter/material.dart';
import '../../widgets/glass_card.dart';

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
        child: GlassCard(
          delay: const Duration(milliseconds: 200),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
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
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0.0, 0.6, 0.8, 0.95, 1.0],
                              colors: [
                                Colors.black, // Links: vollständig sichtbar
                                Colors.black, // Großteil des Bildes sichtbar
                                Colors.black.withAlpha(200), // Sanfter Fade beginnt
                                Colors.black.withAlpha(100), // Starker Fade  
                                Colors.black.withAlpha(0), // Rechts: transparent für weichen Übergang
                              ],
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstIn, // Ändere BlendMode für richtiges Masking
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
          ), // ClipRRect schließen
        ),
      ),
      ),
    );
  }
}
