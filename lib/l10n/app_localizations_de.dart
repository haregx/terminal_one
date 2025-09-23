// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Startseite';

  @override
  String get welcomeMessage => 'Willkommen bei Terminal.One';

  @override
  String get enterAccessCode => 'Gib deinen Promo-Code ein';

  @override
  String get verifyCode => 'Code prüfen';

  @override
  String get submit => 'Absenden';

  @override
  String get continueText => 'Weiter';

  @override
  String get secureTerminalAccess => 'Sicherer Terminal-Zugang';

  @override
  String get login => 'Anmelden';

  @override
  String get enterPin => 'Gib deine PIN ein';

  @override
  String get forgotPin => 'Kennwort vergessen?';

  @override
  String get clearCode => 'Code löschen';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Code eingegeben: $enteredDigits von $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Code vollständig: $code';
  }

  @override
  String get promoCodeSignupText => 'Für mehr Promo-Codes melde dich an';

  @override
  String get toRegistration => 'Registrieren';

  @override
  String get toLogin => 'Anmelden';

  @override
  String get whatIsPromoCode => 'Was ist ein Promo-Code?';

  @override
  String get promoCodeExplanation =>
      'Ein Promo-Code ist ein spezieller Rabattcode, den du von Unternehmen erhältst. Mit diesem Code kannst du Vergünstigungen, Rabatte oder besondere Angebote nutzen. Gib einfach deinen Code hier ein und entdecke, welche Vorteile auf dich warten!';

  @override
  String get understood => 'Verstanden';

  @override
  String get emailAddress => 'E-Mail-Adresse';

  @override
  String get emailHint => 'erika@example.com';

  @override
  String get emailValidationError => 'Bitte gültige E-Mail-Adresse eingeben';

  @override
  String get password => 'Kennwort';

  @override
  String get passwordHint => 'Sicheres Kennwort eingeben';

  @override
  String get passwordRequirements => 'Passwort-Anforderungen:';

  @override
  String get passwordMinLength => 'Mindestens 8 Zeichen';

  @override
  String get passwordNeedNumber => 'Mindestens eine Ziffer';

  @override
  String get passwordNeedUppercase => 'Mindestens ein Großbuchstabe';

  @override
  String get passwordNeedLowercase => 'Mindestens ein Kleinbuchstabe';

  @override
  String get showPassword => 'Passwort anzeigen';

  @override
  String get hidePassword => 'Passwort verbergen';

  @override
  String get passwordStrengthWeak => 'Schwach';

  @override
  String get passwordStrengthMedium => 'Mittel';

  @override
  String get passwordStrengthGood => 'Gut';

  @override
  String get passwordStrengthStrong => 'Stark';

  @override
  String get confirmPassword => 'Kennwort bestätigen';

  @override
  String get confirmPasswordHint => 'Kennwort wiederholen';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get registerButton => 'Registrieren';

  @override
  String get backToLogin => 'Zurück zur Anmeldung';

  @override
  String get or => 'oder';

  @override
  String get loginDescription =>
      'Melde dich mit deiner E-Mail-Adresse und deinem Kennwort an.';

  @override
  String get registerDescription =>
      'Erstelle ein neues Konto mit deiner E-Mail-Adresse und einem sicheren Kennwort.';

  @override
  String get passwordRequest => 'Kennwort anfordern';

  @override
  String get passwordRequestDescription =>
      'Gib deine E-Mail-Adresse ein und wir senden dir ein neues Kennwort.';

  @override
  String get sendPasswordRequest => 'Neues Kennwort anfordern';

  @override
  String get passwordRequestSent =>
      'Ein neues Kennwort wurde an deine E-Mail-Adresse gesendet.';

  @override
  String passwordRequestSuccess(String email) {
    return 'Eine E-Mail zum Zurücksetzen wurde an $email gesendet.';
  }

  @override
  String get passwordRequestFailed =>
      'Passwort-Anfrage fehlgeschlagen. Bitte überprüfe Deine Eingaben.';

  @override
  String get genericError =>
      'Es ist ein Fehler aufgetreten. Bitte versuche es später erneut.';
}
