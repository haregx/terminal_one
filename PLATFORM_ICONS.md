# Platform-Aware Icons Implementation

## 🎯 Übersicht

Die App verwendet jetzt **platform-bewusste Icons**, die automatisch den iOS Human Interface Guidelines und Android Material Design Guidelines folgen.

## 📱 Implementierte Icons

### HomeScreen
- **Einstellungen-Icon** (AppBar): `Icons.settings_outlined`
- **Hilfe-Icon** (Promo-Code Info): `Icons.help_outline` + Text
- **Login-Icon** (Zur Registrierung): `Icons.login`
- **Clear-Icon** (Code löschen): `Icons.clear_all`

### LoginScreen  
- **Hilfe-Icon** (PIN vergessen): `Icons.help_outline`

## 🔧 Platform-Spezifische Anpassungen

### iOS (SF Symbols Style)
- **Touch Target**: Mindestens 44pt x 44pt
- **Icon-Größe**: 22pt (Icon-only), 18pt (mit Text)
- **Padding**: 8pt Innenabstand
- **Button-Stil**: CupertinoButton für native iOS-Optik

### Android (Material Icons)
- **Touch Target**: Mindestens 48dp x 48dp  
- **Icon-Größe**: 24dp (Icon-only), 16dp (mit Text)
- **Button-Stil**: IconButton/ElevatedButton.icon für Material Design

## 💡 Verwendung

```dart
// Icon-only Button
PlatformIconButton(
  icon: Icons.settings_outlined,
  tooltip: 'Einstellungen',
  onPressed: () {},
)

// Button mit Icon + Text
PlatformButton(
  icon: Icons.login,
  isSecondary: true,
  child: Text('Anmelden'),
  onPressed: () {},
)
```

## ✅ Guidelines-Konformität

### iOS Human Interface Guidelines ✓
- ✅ SF Symbols kompatible Icon-Größen
- ✅ 44pt Mindest-Touch-Target
- ✅ Cupertino Design Language
- ✅ Konsistente Icon-Abstände

### Android Material Design ✓  
- ✅ Material Icons Standard-Größen
- ✅ 48dp Mindest-Touch-Target
- ✅ Material Design 3 Buttons
- ✅ Accessible color contrast

## 🚀 Nächste Schritte

1. **Mehr Icons hinzufügen**: Navigation, Aktionen, Status
2. **Custom Icons**: SF Symbols (iOS) und Material Icons (Android)
3. **Icon-Themes**: Dark/Light Mode angepasste Icon-Farben
4. **Accessibility**: VoiceOver/TalkBack Unterstützung erweitern

## 📋 Icon-Bibliothek Empfehlungen

### Häufig verwendete Icons
- **Navigation**: `arrow_back`, `menu`, `close`
- **Aktionen**: `add`, `edit`, `delete`, `share`
- **Status**: `check`, `warning`, `error`, `info`
- **Benutzer**: `person`, `login`, `logout`, `settings`

### Platform-spezifische Alternativen
- **iOS**: Verwende CupertinoIcons für native Optik
- **Android**: Verwende Icons.* für Material Design

Alle Icons sind jetzt **automatisch platform-aware** und folgen den jeweiligen Design-Guidelines! 🎉