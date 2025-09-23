# API Services Documentation

Diese Dateien bieten eine vollständige HTTP-API-Integration für deine Flutter-App.

## Übersicht

### 📦 Dateien

- **`api_service.dart`** - Zentrale HTTP-Service-Klasse
- **`auth_service.dart`** - Authentication & Token-Management  
- **`api_exceptions.dart`** - Typisierte Exception-Klassen
- **`api_response.dart`** - Standardisierte Response-Models
- **`api_usage_example.dart`** - Beispiele für die Verwendung

## 🚀 Setup & Initialisierung

### 1. Dependencies (bereits hinzugefügt)
```yaml
dependencies:
  dio: ^5.4.0
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
```

### 2. API-Service initialisieren

```dart
// In main.dart oder einem Service-Locator
await ExampleApiUsage().initializeApi();
```

### 3. Base-URL konfigurieren

```dart
ApiService().initialize(
  baseUrl: 'https://your-api.example.com/api/v1',
  timeout: Duration(seconds: 30),
  headers: {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  },
);
```

## 💻 Verwendung

### Authentication

```dart
final authService = AuthService();

// Login
try {
  final response = await authService.login(
    email: 'user@example.com',
    password: 'password',
  );
  print('Logged in: ${response.user?.email}');
} on ValidationException catch (e) {
  // Validation-Fehler anzeigen
  print('Validation errors: ${e.validationErrors}');
} on AuthenticationException catch (e) {
  // Login fehlgeschlagen
  print('Login failed: ${e.message}');
}

// Logout
await authService.logout();
```

### HTTP-Requests

```dart
final apiService = ApiService();

// GET-Request
final users = await apiService.get<List<dynamic>>('/users');

// POST-Request mit Daten
final newUser = await apiService.post<Map<String, dynamic>>(
  '/users',
  data: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
);

// PUT-Request
final updatedUser = await apiService.put<Map<String, dynamic>>(
  '/users/123',
  data: {'name': 'Jane Doe'},
);

// DELETE-Request
await apiService.delete('/users/123');
```

### File-Upload

```dart
final fileUrl = await apiService.uploadFile<Map<String, dynamic>>(
  '/upload',
  File('/path/to/file.jpg'),
  fileField: 'image',
  additionalData: {'description': 'Profile picture'},
  onProgress: (sent, total) {
    print('Progress: ${(sent / total * 100).round()}%');
  },
);
```

### Error-Handling

```dart
try {
  final result = await apiService.get('/protected-endpoint');
} on NetworkException catch (e) {
  // Netzwerk-Fehler (kein Internet, Timeout)
  showError('Netzwerk-Problem: ${e.message}');
} on AuthenticationException catch (e) {
  // Authentication-Fehler (401, 403)
  navigateToLogin();
} on ValidationException catch (e) {
  // Validation-Fehler (422)
  showValidationErrors(e.validationErrors);
} on ServerException catch (e) {
  // Server-Fehler (5xx)
  showError('Server-Problem: ${e.message}');
} on ClientException catch (e) {
  // Client-Fehler (4xx)
  showError('Request-Fehler: ${e.message}');
}
```

## 🛠️ Features

### ✅ Implementiert

- **HTTP-Methods**: GET, POST, PUT, PATCH, DELETE
- **File-Upload**: Multipart-Form-Data mit Progress
- **Authentication**: Token-Management mit automatischem Refresh
- **Error-Handling**: Typisierte Exceptions für verschiedene Fehlertypen
- **Retry-Logic**: Automatische Wiederholung bei temporären Fehlern
- **Logging**: Debug-Ausgaben für Requests/Responses
- **Interceptors**: Request/Response-Modifikation
- **Timeouts**: Konfigurierbare Request-Timeouts

### 🔄 JSON-Serialization

Die Response-Models nutzen `json_serializable` für automatische JSON-Konvertierung:

```bash
# Code generieren nach Änderungen an Models
dart run build_runner build
```

### 🎯 Platform-spezifisch

Der Service ist platform-agnostic und funktioniert auf:
- iOS
- Android  
- Web
- Desktop (Windows, macOS, Linux)

## 📝 Anpassungen

### Base-URL ändern

```dart
ApiService().initialize(
  baseUrl: 'https://your-new-api.com/v2',
);
```

### Custom Headers

```dart
ApiService().initialize(
  baseUrl: 'https://api.example.com',
  headers: {
    'X-API-Key': 'your-api-key',
    'X-Client-Version': '1.0.0',
  },
);
```

### Eigene Exception-Types

```dart
class CustomException extends ApiException {
  const CustomException(super.message, {super.statusCode});
}
```

### Token-Storage erweitern

In `auth_service.dart` die TODOs für SharedPreferences implementieren:

```dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _saveTokensToStorage() async {
  final prefs = await SharedPreferences.getInstance();
  if (_accessToken != null) {
    await prefs.setString('access_token', _accessToken!);
  }
  // ... weitere Token speichern
}
```

## 🔐 Sicherheit

- Token werden automatisch in Authorization-Header gesetzt
- Sensitive Daten nur über HTTPS übertragen
- Token-Refresh verhindert Session-Timeouts
- Automatisches Logout bei Authentication-Fehlern

## 📱 Integration in UI

```dart
// In deinen Screens/Widgets
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _apiUsage = ExampleApiUsage();
  
  Future<void> _loadData() async {
    final users = await _apiUsage.handleApiCall(() => 
      _apiUsage.fetchUsers()
    );
    
    if (users != null) {
      // Daten verwenden
      setState(() {
        // UI aktualisieren
      });
    }
  }
}
```

Diese API-Services bieten eine solide Grundlage für alle HTTP-basierten API-Integrationen in deiner Flutter-App! 🚀