## Platform Guidelines Enforcement

### VS Code Snippets (fügen Sie diese zu .vscode/settings.json hinzu):

```json
{
  "dart.flutterScreenSnippets": true,
  "editor.snippetSuggestions": "top",
  "dart.previewFlutterUiGuides": true,
  "files.associations": {
    "*.dart": "dart"
  }
}
```

### Automatische Code-Templates

1. **Tippen Sie `fscreen`** für einen neuen Screen
2. **Tippen Sie `fscreenform`** für einen Form-Screen  
3. **Tippen Sie `fscreenlist`** für einen List-Screen

### Coding Standards Checklist

#### ✅ Für jeden neuen Screen:

**Base Requirements:**
- [ ] Erweitert `PlatformBaseScreen` 
- [ ] Implementiert `buildContent(BuildContext context)`
- [ ] Verwendet `getPlatformSpacing()` für Abstände
- [ ] Verwendet `getPlatformTextStyle()` für Text
- [ ] Nutzt `PlatformButton` statt Standard-Buttons

**Icons & Buttons:**
- [ ] Alle Buttons verwenden `PlatformButton` oder `PlatformIconButton`
- [ ] Icons haben Tooltips (`tooltip: 'Beschreibung'`)
- [ ] Touch-Targets sind groß genug (automatisch durch Platform-Widgets)

**Typography:**
- [ ] Keine manuellen TextStyle-Definitionen
- [ ] Verwendet Theme-basierte Text-Styles
- [ ] Platform-spezifische Font-Familien (automatisch)

**Navigation:**
- [ ] Verwendet `navigateToPlatformScreen()` für Navigation
- [ ] Platform-spezifische Übergänge (automatisch)

**Dialogs & Messages:**
- [ ] Verwendet `showPlatformDialog()` für Dialogs
- [ ] Verwendet `showPlatformMessage()` für Feedback

**Forms (falls zutreffend):**
- [ ] Nutzt `PlatformFormMixin`
- [ ] Verwendet `PlatformTextField` für Eingaben
- [ ] Implementiert `validateForm()` und `submitForm()`

**Lists (falls zutreffend):**
- [ ] Nutzt `PlatformListMixin`
- [ ] Verwendet `buildPlatformListTile()` für List-Items
- [ ] Verwendet `buildSectionHeader()` für Abschnitte

### Code-Review Checklist

**Vor dem Commit prüfen:**

```bash
# 1. Flutter Analyze (automatische Checks)
flutter analyze

# 2. Platform-spezifische Checks
grep -r "showDialog(" lib/screens/  # Sollte leer sein
grep -r "AlertDialog(" lib/screens/ # Sollte leer sein
grep -r "TextButton(" lib/screens/  # Sollte leer sein
grep -r "ElevatedButton(" lib/screens/ # Sollte leer sein

# 3. Typography Checks  
grep -r "TextStyle(" lib/screens/   # Sollte minimal sein
grep -r "fontSize:" lib/screens/    # Sollte leer sein
```

### Platform-Testing

**Testen auf beiden Plattformen:**

```bash
# iOS Simulator
flutter run -d ios

# Android Emulator  
flutter run -d android

# Desktop (für Entwicklung)
flutter run -d macos
flutter run -d windows
flutter run -d linux
```

### Debugging Platform-Issues

**Platform-spezifische Debug-Ausgaben:**

```dart
// In Ihren Screens:
debugPrint('Platform: ${PlatformUtils.isIOSContext(context) ? "iOS" : "Android"}');
debugPrint('Font Family: ${PlatformTypography.primaryFontFamily}');
```

### Enforcement Tools

**Git Hooks (optional):**

Erstellen Sie `.git/hooks/pre-commit`:

```bash
#!/bin/sh
echo "Checking platform compliance..."

# Check for prohibited widgets
if grep -r "showDialog(" lib/screens/ --include="*.dart"; then
    echo "❌ Use showPlatformDialog() instead of showDialog()"
    exit 1
fi

if grep -r "AlertDialog(" lib/screens/ --include="*.dart"; then
    echo "❌ Use PlatformUtils.showPlatformDialog() instead of AlertDialog"
    exit 1
fi

if grep -r "TextButton(" lib/screens/ --include="*.dart"; then
    echo "❌ Use PlatformButton(isSecondary: true) instead of TextButton"
    exit 1
fi

echo "✅ Platform compliance check passed"
```

### Team Guidelines

**Für neue Entwickler:**

1. **Starten Sie immer mit Templates:** `fscreen`, `fscreenform`, `fscreenlist`
2. **Niemals Standard Flutter Widgets in Screens verwenden**
3. **Immer `PlatformBaseScreen` erweitern**
4. **Testen Sie auf beiden Plattformen**
5. **Verwenden Sie die bereitgestellten Helper-Methoden**

### Dokumentation

**Für jeden Screen dokumentieren:**

```dart
/// ExampleScreen - Platform-compliant screen
/// 
/// Features:
/// - Automatische iOS/Android Anpassung
/// - Form-Validierung mit Platform-UI
/// - Loading-States mit platform-spezifischen Indikatoren
/// - Navigation mit korrekten Übergängen
/// 
/// Platform-spezifische Eigenschaften:
/// iOS: Cupertino-Stil mit SF Fonts
/// Android: Material Design 3 mit Roboto
class ExampleScreen extends PlatformBaseScreen {
  // Implementation...
}
```