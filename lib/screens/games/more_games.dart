import 'package:flutter/material.dart';
import 'package:terminal_one/components/cards/promocode_card.dart';
import '../../widgets/glassmorphism_scaffold.dart';
import '../../widgets/appbar_aware_safe_area.dart';
import '../../data/promo_data.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MoreGamesScreen extends StatefulWidget {
  final double minCardWidth;
  final double maxCardWidth;
  
  const MoreGamesScreen({
    super.key,
    this.minCardWidth = 360.0,
    this.maxCardWidth = 400.0,
  });

  @override
  State<MoreGamesScreen> createState() => _MoreGamesScreenState();
}

class _MoreGamesScreenState extends State<MoreGamesScreen> {
  // Lade Promo-Karten aus zentraler Datenquelle
  final List<PromoData> promoCards = PromoDataSource.getAllCards();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismScaffold(
      title: const Text('More Games'),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.slidersHorizontal),
          tooltip: 'Filter',
          onPressed: () {
            // TODO: Implement filter action
          },
        ),
        IconButton(
          icon: const Icon(LucideIcons.search),
          tooltip: 'Search',
          onPressed: () {
            // TODO: Implement search action
          },
        ),
      ],
      body: AppBarAwareSafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  'Tap a card to play the game.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(166),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Responsives Grid Layout mit GridView
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return _buildResponsiveGridView(constraints.maxWidth);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Responsives Grid Layout mit GridView
  Widget _buildResponsiveGridView(double screenWidth) {
    final double minCardWidth = widget.minCardWidth;
    final double maxCardWidth = widget.maxCardWidth;
    const double cardSpacing = 16.0;
    // Die Kartenhöhe wird exakt auf den sichtbaren Inhalt gesetzt (z.B. 200.0, ggf. anpassen)
    const double cardHeight = 190.0;

    // Berechne optimale Kartenbreite und Anzahl pro Zeile
    final availableWidth = screenWidth - (cardSpacing * 2);
    final cardsPerRow = (availableWidth / minCardWidth).floor().clamp(1, 4);
    final cardWidth = ((availableWidth - (cardSpacing * (cardsPerRow - 1))) / cardsPerRow)
        .clamp(minCardWidth, maxCardWidth);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cardsPerRow,
        crossAxisSpacing: cardSpacing,
        mainAxisSpacing: cardSpacing,
        childAspectRatio: cardWidth / cardHeight,
      ),
      itemCount: promoCards.length,
      itemBuilder: (context, index) {
        final card = promoCards[index];
        return _buildConstrainedCard(cardWidth, cardHeight, card);
      },
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
    );
  }

  // Helper method für Karten mit fester Breite und Höhe
  Widget _buildConstrainedCard(double width, double height, PromoData card) {
    return SizedBox(
      width: width,
      height: height,
      child: PromoCodeCard(
        rowGuid: card.rowGuid,
        imageUrl: card.imageUrl,
        title: card.title,
        description: card.description,
        promoCode: card.promoCode,
        validity: card.validity,
        onTap: () {},
        // Entferne ggf. Padding/Margin in PromoCodeCard selbst, falls dort noch zusätzlicher Abstand ist!
      ),
    );
  }
}