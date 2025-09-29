import 'package:flutter/material.dart';
import 'package:terminal_one/components/cards/promocode_card.dart';
import 'package:terminal_one/widgets/glassmorphism_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MoreGamesScreen extends StatefulWidget {
  const MoreGamesScreen({super.key});

  @override
  State<MoreGamesScreen> createState() => _MoreGamesScreenState();
}

class _MoreGamesScreenState extends State<MoreGamesScreen> {
  static const imageUrl1 = 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80';
  static const imageUrl2 = 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80';
  static const imageUrl3 = 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80';
  static const imageUrl4 = 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 8,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    'Tap a card to play the game.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(166),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                PromoCodeCard(
                  rowGuid: 'ABCD',
                  imageUrl: imageUrl1, 
                  title: 'Test Card 1',
                  description: 'This is the description of Card 1 with a long long text that should be truncated',
                  promoCode: '123456',
                  validity: '31.12.2023', 
                  onTap: () {  },
                ),
                PromoCodeCard(
                  rowGuid: 'EFGH',
                  imageUrl: imageUrl2, 
                  title: 'Test Card 2',
                  description: 'This is the description of Card 2',
                  promoCode: '123456',
                  validity: '31.12.2023', 
                  onTap: () {  },
                ),
                PromoCodeCard(
                  rowGuid: 'IJKL',
                  imageUrl: imageUrl3, 
                  title: 'Test Card 3',
                  description: 'This is the description of Card 3',
                  promoCode: '123456',
                  validity: '31.12.2023', 
                  onTap: () {  },
                ),
                PromoCodeCard(
                  rowGuid: 'MNOP',
                  imageUrl: imageUrl4, 
                  title: 'Test Card 4',
                  description: 'This is the description of Card 4',
                  promoCode: '123456',
                  validity: '31.12.2023', 
                  onTap: () {  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
