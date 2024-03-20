import 'package:easy_localization/easy_localization.dart';

// ignore_for_file: constant_identifier_names

class Strings {
  static const validationEmailEmpty = 'E-mail está vazio.';
  static const validationEmailInvalid = 'Insira um e-mail válido.';
  static const validationPasswordEmpty = 'Senha está vazia.';
  static const errorPasswordTooShort = 'A senha deve ter pelo menos 8 caracteres';
  static const errorPasswordTooWeak =
      'Ops! sua senha precisa de força\n(Números, letras maiusculas e minusculas \ne Carácteres especiais: "! @ # \$ % ^ & *")';
// regex
  static const String re_not_number = r'[^\d]';
  static NumberFormat formatTwoDecimals = NumberFormat('0.00');
  static const String re_phone = r'^\(\d{2}\)\d{4,5}-\d{4}$';
  static const String re_name = r"[A-Za-zÀ-ÖØ-öø-ÿ0-9']+\s+[A-Za-zÀ-ÖØ-öø-ÿ0-9']+";

  static const String re_date = r'(\d{2})/(\d{2})/(\d{4})';

// login page
  static const String error_empty_password = 'Digite sua senha';
  static const String error_password_too_short = 'A senha deve ter pelo menos 8 caracteres';
  static const String error_email = 'Digite um e-mail válido';
  static const String label_email = 'E-MAIL';
  static const String label_password = 'SENHA';
  static const String hint_type_your_email = 'Digite seu e-mail';
  static const String hint_type_your_password = 'Digite sua senha';
  static const String loginOtpTitleButton = 'ENTRAR COM CELULAR';
  static const String loginPageNotAccount = 'Não Possui conta? Clique aqui!';
  static const String loginPageTitleButton = 'Entrar';
  static const String loginPageTitle = 'Entrar';
  static const String loginPageForgetPassword = 'Esqueceu a senha?';
  static const String error_name = 'Digite seu nome completo';
  static const String error_empty_name = 'Digite seu nome';
  static const String error_name_too_short = 'O seu nome deve ter pelo menos 6 caracteres';

  // firebase errors

  static const String AUTH_ERROR_API_NOT_AVAILABLE = 'ERROR_API_NOT_AVAILABLE';
  static const String AUTH_ERROR_UNKNOWN = 'unknown';
  static const String AUTH_ERROR_INVALID_CUSTOM_TOKEN = 'invalid_custom_token';
  static const String AUTH_ERROR_CUSTOM_TOKEN_MISMATCH = 'custom-token-mismatch';
  static const String AUTH_ERROR_INVALID_CREDENTIAL = 'invalid-credential';
  static const String AUTH_ERROR_USER_DISABLED = 'user-disabled';
  static const String AUTH_ERROR_OPERATION_NOT_ALLOWED = 'operation-not-allowed';
  static const String AUTH_ERROR_EMAIL_ALREADY_IN_USE = 'email-already-in-use';
  static const String AUTH_ERROR_INVALID_EMAIL = 'invalid-email';
  static const String AUTH_ERROR_WRONG_PASSWORD = 'wrong-password';
  static const String AUTH_ERROR_TOO_MANY_REQUESTS = 'too-many-requests';
  static const String AUTH_ERROR_USER_NOT_FOUND = 'user-not-found';
  static const String AUTH_ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL = 'account-exists-with-different-credential';
  static const String AUTH_ERROR_REQUIRES_RECENT_LOGIN = 'requires-recent-login';
  static const String AUTH_ERROR_PROVIDER_ALREADY_LINKED = 'provider-already-linked';
  static const String AUTH_ERROR_NO_SUCH_PROVIDER = 'no-such-provider';
  static const String AUTH_ERROR_INVALID_USER_TOKEN = 'invalid-user-token';
  static const String AUTH_ERROR_NETWORK_REQUEST_FAILED = 'network-request-failed';
  static const String AUTH_ERROR_USER_TOKEN_EXPIRED = 'user-token-expired';
  static const String AUTH_ERROR_INVALID_API_KEY = 'invalid-api-key';
  static const String AUTH_ERROR_USER_MISMATCH = 'user-mismatch';
  static const String AUTH_ERROR_CREDENTIAL_ALREADY_IN_USE = 'credential-already-in-use';
  static const String AUTH_ERROR_WEAK_PASSWORD = 'weak-password';
  static const String AUTH_ERROR_APP_NOT_AUTHORIZED = 'app-not-authorized';
  static const String AUTH_ERROR_EXPIRED_ACTION_CODE = 'expired-action-code';
  static const String AUTH_ERROR_INVALID_ACTION_CODE = 'invalid-action-code';
  static const String AUTH_ERROR_INVALID_MESSAGE_PAYLOAD = 'invalid-message-payload';
  static const String AUTH_ERROR_INVALID_SENDER = 'invalid-sender';
  static const String AUTH_ERROR_INVALID_RECIPIENT_EMAIL = 'invalid-recipient-email';
  static const String AUTH_ERROR_MISSING_EMAIL = 'missing-email';
  static const String AUTH_ERROR_MISSING_PASSWORD = 'missing-password';
  static const String AUTH_ERROR_MISSING_IOS_BUNDLE_ID = 'missing-ios-bundle-id';
  static const String AUTH_ERROR_MISSING_ANDROID_PKG_NAME = 'missing-android-pkg-name';
  static const String AUTH_ERROR_UNAUTHORIZED_DOMAIN = 'unauthorized-domain';
  static const String AUTH_ERROR_INVALID_CONTINUE_URI = 'invalid-continue-uri';
  static const String AUTH_ERROR_MISSING_CONTINUE_URI = 'missing-continue-uri';
  static const String AUTH_ERROR_MISSING_PHONE_NUMBER = 'missing-phone-number';
  static const String AUTH_ERROR_INVALID_PHONE_NUMBER = 'invalid-phone-number';
  static const String AUTH_ERROR_MISSING_VERIFICATION_CODE = 'missing-verification-code';
  static const String AUTH_ERROR_INVALID_VERIFICATION_CODE = 'invalid-verification-code';
  static const String AUTH_ERROR_MISSING_VERIFICATION_ID = 'missing-verification-id';
  static const String AUTH_ERROR_INVALID_VERIFICATION_ID = 'invalid-verification-id';
  static const String AUTH_MISSING_APP_CREDENTIAL = 'missing-app-credential';
  static const String AUTH_INVALID_APP_CREDENTIAL = 'invalid-app-credential';
  static const String AUTH_ERROR_SESSION_EXPIRED = 'session-expired';
  static const String AUTH_ERROR_QUOTA_EXCEEDED = 'quota-exceeded';
  static const String AUTH_ERROR_MISSING_APP_TOKEN = 'missing-app-token';
  static const String AUTH_ERROR_NOTIFICATION_NOT_FORWARDED = 'notification-not-forwarded';
  static const String AUTH_ERROR_APP_NOT_VERIFIED = 'app-not-verified';
  static const String AUTH_ERROR_CAPTCHA_CHECK_FAILED = 'captcha-check-failed';
  static const String AUTH_ERROR_WEB_CONTEXT_ALREADY_PRESENTED = 'web-context-already-presented';
  static const String AUTH_ERROR_WEB_CONTEXT_CANCELLED = 'web-context-cancelled';
  static const String AUTH_ERROR_APP_VERIFICATION_FAILED = 'app-verification-failed';
  static const String AUTH_ERROR_INVALID_CLIENT_ID = 'invalid-client-id';
  static const String AUTH_ERROR_WEB_NETWORK_REQUEST_FAILED = 'web-network-request-failed';
  static const String AUTH_ERROR_WEB_INTERNAL_ERROR = 'web-internal-error';
  static const String AUTH_ERROR_NULL_USER = 'null-user';
  static const String AUTH_ERROR_KEYCHAIN_ERROR = 'keychain-error';
  static const String AUTH_ERROR_INTERNAL_ERROR = 'internal-error';
  static const String AUTH_ERROR_MALFORMED_JWT = 'malformed-jwt';
  static const String AUTH_ERROR_SIGN_IN_FAILED = 'sign_in_failed';
}
