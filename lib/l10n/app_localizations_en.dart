// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get welcomeMessage => 'Welcome to Terminal.One';

  @override
  String get enterAccessCode => 'Enter your promo code';

  @override
  String get verifyCode => 'Verify Code';

  @override
  String get submit => 'Submit';

  @override
  String get continueText => 'Continue';

  @override
  String get secureTerminalAccess => 'Secure Terminal Access';

  @override
  String get login => 'Sign In';

  @override
  String get enterPin => 'Enter your PIN';

  @override
  String get forgotPin => 'Forgot Password?';

  @override
  String get clearCode => 'Clear Code';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Code entered: $enteredDigits of $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Code completed: $code';
  }

  @override
  String get promoCodeSignupText => 'For more promo codes, sign in';

  @override
  String get toRegistration => 'Sign Up';

  @override
  String get toLogin => 'Sign In';

  @override
  String get whatIsPromoCode => 'What is a Promo Code?';

  @override
  String get promoCodeExplanation =>
      'A promo code is a special discount code you receive from companies. With this code, you can use discounts, rebates, or special offers. Simply enter your code here and discover what benefits await you!';

  @override
  String get understood => 'Got it';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailHint => 'erika@example.com';

  @override
  String get emailValidationError => 'Please enter a valid email address';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter a secure password';

  @override
  String get passwordRequirements => 'Password requirements:';

  @override
  String get passwordMinLength => 'At least 8 characters';

  @override
  String get passwordNeedNumber => 'At least one number';

  @override
  String get passwordNeedUppercase => 'At least one uppercase letter';

  @override
  String get passwordNeedLowercase => 'At least one lowercase letter';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get passwordStrengthWeak => 'Weak';

  @override
  String get passwordStrengthMedium => 'Medium';

  @override
  String get passwordStrengthGood => 'Good';

  @override
  String get passwordStrengthStrong => 'Strong';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Repeat your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerButton => 'Register';

  @override
  String get backToLogin => 'Back to Sign In';

  @override
  String get or => 'or';

  @override
  String get loginDescription =>
      'Sign in with your email address and password.';

  @override
  String get registerDescription =>
      'Create a new account with your email address and a secure password.';

  @override
  String get passwordRequest => 'Request New Password';

  @override
  String get passwordRequestDescription =>
      'Enter your email address and we\'ll send you a new password.';

  @override
  String get sendPasswordRequest => 'Request New Password';

  @override
  String get passwordRequestSent =>
      'A new password has been sent to your email address.';

  @override
  String passwordRequestSuccess(String email) {
    return 'A password reset email has been sent to $email.';
  }

  @override
  String get passwordRequestFailed =>
      'Password reset request failed. Please check your input.';

  @override
  String get genericError => 'An error occurred. Please try again later.';
}
