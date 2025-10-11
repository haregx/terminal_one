/// Promo Card Data Model und Sample Data
/// 
/// Zentrale Datenhaltung für PromoCode-Karten

class PromoData {
  final String rowGuid;
  final String imageUrl;
  final String title;
  final String description;
  final String promoCode;
  final String validity;

  const PromoData({
    required this.rowGuid,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.promoCode,
    required this.validity,
  });
}

/// Sample Promo Card Data
class PromoDataSource {
  static const List<PromoData> sampleCards = [
    PromoData(
      rowGuid: 'ABCD',
      imageUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 1',
      description: 'This is the description of Card 1 with a long long text that should be truncated',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'EFGH',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 2',
      description: 'This is the description of Card 2',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
     PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ), PromoData(
      rowGuid: 'IJKL',
      imageUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 3',
      description: 'This is the description of Card 3',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
    PromoData(
      rowGuid: 'MNOP',
      imageUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=400&q=80',
      title: 'Test Card 4',
      description: 'This is the description of Card 4',
      promoCode: '123456',
      validity: '31.12.2023',
    ),
  ];

  /// Gibt alle verfügbaren Promo-Karten zurück
  static List<PromoData> getAllCards() => sampleCards;

  /// Sucht eine Karte anhand der GUID
  static PromoData? getCardByGuid(String guid) {
    try {
      return sampleCards.firstWhere((card) => card.rowGuid == guid);
    } catch (e) {
      return null;
    }
  }
}