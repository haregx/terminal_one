// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get welcomeMessage => 'Benvenuto in Terminal.One';

  @override
  String get enterAccessCode => 'Inserisci il tuo codice promozionale';

  @override
  String get verifyCode => 'Verifica Codice';

  @override
  String get submit => 'Invia';

  @override
  String get continueText => 'Continua';

  @override
  String get secureTerminalAccess => 'Accesso Sicuro al Terminale';

  @override
  String get login => 'Accedi';

  @override
  String get enterPin => 'Inserisci il tuo PIN';

  @override
  String get forgotPin => 'Password dimenticata?';

  @override
  String get clearCode => 'Cancella Codice';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Codice inserito: $enteredDigits di $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Codice completato: $code';
  }

  @override
  String get promoCodeSignupText => 'Per ulteriori codici promozionali, accedi';

  @override
  String get toRegistration => 'Registrati';

  @override
  String get toLogin => 'Accedi';

  @override
  String get whatIsPromoCode => 'Cos\'è un Codice Promozionale?';

  @override
  String get promoCodeExplanation =>
      'Un codice promozionale è un codice sconto speciale che ricevi dalle aziende. Con questo codice, puoi usufruire di sconti, rimborsi o offerte speciali. Inserisci semplicemente il tuo codice qui e scopri quali vantaggi ti aspettano!';

  @override
  String get understood => 'Capito';

  @override
  String get emailAddress => 'Indirizzo Email';

  @override
  String get emailHint => 'erika@esempio.com';

  @override
  String get emailValidationError => 'Inserisci un indirizzo email valido';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Inserisci una password sicura';

  @override
  String get passwordRequirements => 'Requisiti password:';

  @override
  String get passwordMinLength => 'Almeno 8 caratteri';

  @override
  String get passwordNeedNumber => 'Almeno un numero';

  @override
  String get passwordNeedUppercase => 'Almeno una lettera maiuscola';

  @override
  String get passwordNeedLowercase => 'Almeno una lettera minuscola';

  @override
  String get showPassword => 'Mostra password';

  @override
  String get hidePassword => 'Nascondi password';

  @override
  String get passwordStrengthWeak => 'Debole';

  @override
  String get passwordStrengthMedium => 'Media';

  @override
  String get passwordStrengthGood => 'Buona';

  @override
  String get passwordStrengthStrong => 'Forte';

  @override
  String get confirmPassword => 'Conferma Password';

  @override
  String get confirmPasswordHint => 'Ripeti la tua password';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get registerTitle => 'Crea Account';

  @override
  String get registerButton => 'Registrati';

  @override
  String get backToLogin => 'Torna all\'Accesso';

  @override
  String get or => 'o';

  @override
  String get loginDescription =>
      'Accedi con il tuo indirizzo email e password.';

  @override
  String get registerDescription =>
      'Crea un nuovo account con il tuo indirizzo email e una password sicura.';

  @override
  String get passwordRequest => 'Richiedi Nuova Password';

  @override
  String get passwordRequestDescription =>
      'Inserisci il tuo indirizzo email e ti invieremo una nuova password.';

  @override
  String get sendPasswordRequest => 'Richiedi Nuova Password';

  @override
  String get passwordRequestSent =>
      'Una nuova password è stata inviata al tuo indirizzo email.';

  @override
  String passwordRequestSuccess(String email) {
    return 'Una email per il reset della password è stata inviata a $email.';
  }

  @override
  String get passwordRequestFailed =>
      'La richiesta di reset della password non è riuscita. Controlla i dati inseriti.';

  @override
  String get genericError => 'Si è verificato un errore. Riprova più tardi.';
}
