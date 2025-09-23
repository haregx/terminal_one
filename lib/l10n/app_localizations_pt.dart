// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Terminal.One';

  @override
  String get homeScreenTitle => 'Início';

  @override
  String get welcomeMessage => 'Bem-vindo ao Terminal.One';

  @override
  String get enterAccessCode => 'Digite seu código promocional';

  @override
  String get verifyCode => 'Verificar Código';

  @override
  String get submit => 'Enviar';

  @override
  String get continueText => 'Continuar';

  @override
  String get secureTerminalAccess => 'Acesso Seguro ao Terminal';

  @override
  String get login => 'Entrar';

  @override
  String get enterPin => 'Digite seu PIN';

  @override
  String get forgotPin => 'Esqueceu a senha?';

  @override
  String get clearCode => 'Limpar Código';

  @override
  String codeInputProgress(int enteredDigits, int totalDigits) {
    return 'Código digitado: $enteredDigits de $totalDigits';
  }

  @override
  String codeCompleted(String code) {
    return 'Código concluído: $code';
  }

  @override
  String get promoCodeSignupText => 'Para mais códigos promocionais, entre';

  @override
  String get toRegistration => 'Cadastrar-se';

  @override
  String get toLogin => 'Entrar';

  @override
  String get whatIsPromoCode => 'O que é um Código Promocional?';

  @override
  String get promoCodeExplanation =>
      'Um código promocional é um código de desconto especial que você recebe de empresas. Com este código, você pode usar descontos, reembolsos ou ofertas especiais. Simplesmente digite seu código aqui e descubra quais benefícios aguardam você!';

  @override
  String get understood => 'Entendi';

  @override
  String get emailAddress => 'Endereço de Email';

  @override
  String get emailHint => 'erika@exemplo.com';

  @override
  String get emailValidationError =>
      'Por favor, digite um endereço de email válido';

  @override
  String get password => 'Senha';

  @override
  String get passwordHint => 'Digite uma senha segura';

  @override
  String get passwordRequirements => 'Requisitos da senha:';

  @override
  String get passwordMinLength => 'Pelo menos 8 caracteres';

  @override
  String get passwordNeedNumber => 'Pelo menos um número';

  @override
  String get passwordNeedUppercase => 'Pelo menos uma letra maiúscula';

  @override
  String get passwordNeedLowercase => 'Pelo menos uma letra minúscula';

  @override
  String get showPassword => 'Mostrar senha';

  @override
  String get hidePassword => 'Ocultar senha';

  @override
  String get passwordStrengthWeak => 'Fraca';

  @override
  String get passwordStrengthMedium => 'Média';

  @override
  String get passwordStrengthGood => 'Boa';

  @override
  String get passwordStrengthStrong => 'Forte';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get confirmPasswordHint => 'Repita sua senha';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get registerTitle => 'Criar Conta';

  @override
  String get registerButton => 'Cadastrar';

  @override
  String get backToLogin => 'Voltar ao Login';

  @override
  String get or => 'ou';

  @override
  String get loginDescription => 'Entre com seu endereço de email e senha.';

  @override
  String get registerDescription =>
      'Crie uma nova conta com seu endereço de email e uma senha segura.';

  @override
  String get passwordRequest => 'Solicitar Nova Senha';

  @override
  String get passwordRequestDescription =>
      'Digite seu endereço de email e enviaremos uma nova senha.';

  @override
  String get sendPasswordRequest => 'Solicitar Nova Senha';

  @override
  String get passwordRequestSent =>
      'Uma nova senha foi enviada para seu endereço de email.';

  @override
  String passwordRequestSuccess(String email) {
    return 'Um e-mail de redefinição de senha foi enviado para $email.';
  }

  @override
  String get passwordRequestFailed =>
      'A solicitação de redefinição de senha falhou. Verifique seus dados.';

  @override
  String get genericError =>
      'Ocorreu um erro. Por favor, tente novamente mais tarde.';
}
