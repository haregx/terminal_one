/// Basis-Klasse für alle API Requests (entspricht C# Request)
abstract class ApiRequest {
  final String apiKey;
  final int vendor;

  // Vendor Codes (entspricht C# Classes.Codes.Vendors)
  static const int terminalone = 2; // Annahme - könnte angepasst werden

  const ApiRequest({
    required this.apiKey,
    this.vendor = terminalone,
  });

  /// Convert zu JSON - muss von Subklassen implementiert werden
  Map<String, dynamic> toJson();

  /// Basis JSON mit ApiKey und Vendor
  Map<String, dynamic> get baseJson => {
    'apiKey': apiKey,
    'vendor': vendor,
  };
}