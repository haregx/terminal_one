// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Accueil';

  @override
  String get welcomeMessage => 'Bienvenue sur Terminal.One';

  @override
  String get enterAccessCode => 'Entre ton promo code';

  @override
  String get verifyCode => 'Vérifier le Code';

  @override
  String get submit => 'Soumettre';

  @override
  String get continueText => 'Continuer';

  @override
  String get secureTerminalAccess => 'Accès Terminal Sécurisé';

  @override
  String get login => 'Se connecter';

  @override
  String get enterPin => 'Entre ton PIN';

  @override
  String get forgotPin => 'Mot de passe oublié ?';

  @override
  String get clearCode => 'Effacer Code';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Code saisi : $enteredDigits sur $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Code complet : $code';
  }

  @override
  String get promoCodeSignupText => 'Pour plus de codes promo, connecte-toi';

  @override
  String get toRegistration => 'S\'inscrire';

  @override
  String get toLogin => 'Se connecter';

  @override
  String get whatIsPromoCode => 'Qu\'est-ce qu\'un Code Promo ?';

  @override
  String get promoCodeExplanation =>
      'Un promo code est un code de réduction spécial que tu reçois des entreprises. Avec ce code, tu peux utiliser des réductions, des rabais ou des offres spéciales. Entre simplement ton code ici et découvre quels avantages t\'attendent !';

  @override
  String get understood => 'Compris';

  @override
  String get emailAddress => 'E-mail';

  @override
  String get emailHint => 'erika@example.com';

  @override
  String get emailValidationError => 'E-mail invalide';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordHint => 'Entre un mot de passe sécurisé';

  @override
  String get passwordRequirements => 'Exigences du mot de passe :';

  @override
  String get passwordMinLength => 'Au moins 8 caractères';

  @override
  String get passwordNeedNumber => 'Au moins un chiffre';

  @override
  String get passwordNeedUppercase => 'Au moins une majuscule';

  @override
  String get passwordNeedLowercase => 'Au moins une minuscule';

  @override
  String get showPassword => 'Afficher';

  @override
  String get hidePassword => 'Masquer';

  @override
  String get passwordStrengthWeak => 'Faible';

  @override
  String get passwordStrengthMedium => 'Moyen';

  @override
  String get passwordStrengthGood => 'Bon';

  @override
  String get passwordStrengthStrong => 'Fort';

  @override
  String get confirmPassword => 'Confirmer';

  @override
  String get confirmPasswordHint => 'Répète ton mot de passe';

  @override
  String get passwordsDoNotMatch => 'Mots de passe différents';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String get backToLogin => 'Retour';

  @override
  String get or => 'ou';

  @override
  String get loginDescription =>
      'Connecte-toi avec ton adresse e-mail et ton mot de passe.';

  @override
  String get registerDescription =>
      'Crée un nouveau compte avec ton adresse e-mail et un mot de passe sécurisé.';

  @override
  String get passwordRequest => 'Nouveau mot de passe';

  @override
  String get passwordRequestDescription =>
      'Entre ton adresse e-mail et nous t\'enverrons un nouveau mot de passe.';

  @override
  String get sendPasswordRequest => 'Demander';

  @override
  String get passwordRequestSent =>
      'Un nouveau mot de passe a été envoyé à ton adresse e-mail.';

  @override
  String passwordRequestSuccess(String email) {
    return 'Un e-mail de réinitialisation du mot de passe a été envoyé à $email.';
  }

  @override
  String get passwordRequestFailed =>
      'La demande de réinitialisation du mot de passe a échoué. Veuillez vérifier votre saisie.';

  @override
  String get genericError =>
      'Une erreur est survenue. Veuillez réessayer plus tard.';
}
