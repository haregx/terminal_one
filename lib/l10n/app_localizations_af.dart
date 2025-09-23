// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Tuis';

  @override
  String get welcomeMessage => 'Welkom by Terminal.One';

  @override
  String get enterAccessCode => 'Voer jou promosiekode in';

  @override
  String get verifyCode => 'Verifieer Kode';

  @override
  String get submit => 'Stuur';

  @override
  String get continueText => 'Gaan voort';

  @override
  String get secureTerminalAccess => 'Veilige Terminaal Toegang';

  @override
  String get login => 'Teken In';

  @override
  String get enterPin => 'Voer jou PIN in';

  @override
  String get forgotPin => 'Wagwoord vergeet?';

  @override
  String get clearCode => 'Maak Kode Skoon';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Kode ingevoer: $enteredDigits van $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Kode voltooi: $code';
  }

  @override
  String get promoCodeSignupText => 'Vir meer promosiekodes, teken in';

  @override
  String get toRegistration => 'Registreer';

  @override
  String get toLogin => 'Teken In';

  @override
  String get whatIsPromoCode => 'Wat is \'n Promosiekode?';

  @override
  String get promoCodeExplanation =>
      '\'n Promosiekode is \'n spesiale afslagkode wat jy van maatskappye ontvang. Met hierdie kode kan jy afslag, terugbetalings of spesiale aanbiedinge gebruik. Voer eenvoudig jou kode hier in en ontdek watter voordele vir jou wag!';

  @override
  String get understood => 'Verstaan';

  @override
  String get emailAddress => 'E-pos Adres';

  @override
  String get emailHint => 'erika@voorbeeld.com';

  @override
  String get emailValidationError =>
      'Voer asseblief \'n geldige e-pos adres in';

  @override
  String get password => 'Wagwoord';

  @override
  String get passwordHint => 'Voer \'n veilige wagwoord in';

  @override
  String get passwordRequirements => 'Wagwoord vereistes:';

  @override
  String get passwordMinLength => 'Ten minste 8 karakters';

  @override
  String get passwordNeedNumber => 'Ten minste een nommer';

  @override
  String get passwordNeedUppercase => 'Ten minste een hoofletter';

  @override
  String get passwordNeedLowercase => 'Ten minste een kleinletter';

  @override
  String get showPassword => 'Wys wagwoord';

  @override
  String get hidePassword => 'Versteek wagwoord';

  @override
  String get passwordStrengthWeak => 'Swak';

  @override
  String get passwordStrengthMedium => 'Gemiddeld';

  @override
  String get passwordStrengthGood => 'Goed';

  @override
  String get passwordStrengthStrong => 'Sterk';

  @override
  String get confirmPassword => 'Bevestig Wagwoord';

  @override
  String get confirmPasswordHint => 'Herhaal jou wagwoord';

  @override
  String get passwordsDoNotMatch => 'Wagwoorde stem nie ooreen nie';

  @override
  String get registerTitle => 'Skep Rekening';

  @override
  String get registerButton => 'Registreer';

  @override
  String get backToLogin => 'Terug na Teken In';

  @override
  String get or => 'of';

  @override
  String get loginDescription => 'Teken in met jou e-pos adres en wagwoord.';

  @override
  String get registerDescription =>
      'Skep \'n nuwe rekening met jou e-pos adres en \'n veilige wagwoord.';

  @override
  String get passwordRequest => 'Versoek Nuwe Wagwoord';

  @override
  String get passwordRequestDescription =>
      'Voer jou e-pos adres in en ons sal vir jou \'n nuwe wagwoord stuur.';

  @override
  String get sendPasswordRequest => 'Versoek Nuwe Wagwoord';

  @override
  String get passwordRequestSent =>
      '\'n Nuwe wagwoord is na jou e-pos adres gestuur.';

  @override
  String passwordRequestSuccess(String email) {
    return '\'n E-pos vir wagwoordherstel is na $email gestuur.';
  }

  @override
  String get passwordRequestFailed =>
      'Wagwoordherstel versoek het misluk. Kontroleer asseblief jou inskrywing.';

  @override
  String get genericError =>
      '\'n Fout het voorgekom. Probeer asseblief later weer.';
}
