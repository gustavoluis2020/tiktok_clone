import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tiktok_clone/app/utils/strings.dart';

abstract class Validations {
  static String? emailValidator(String? value) {
    final email = value ?? '';
    if (email.isEmpty) return Strings.validationEmailEmpty;
    if (!email.isEmail) return Strings.validationEmailInvalid;
    return null;
  }

  static String? passwordRegisterValidator(String? value) {
    final password = value ?? '';
    final isStrong = RegExp(r'(?=^.{8,}$)(?!.*\s)(?=.*[!@#$%^&*]+)(?=.*[A-Z])(?=.*[a-z]).*$').hasMatch(value!);
    if (password.isEmpty) return Strings.validationPasswordEmpty;
    if (password.length < 8) return Strings.errorPasswordTooShort;
    if (!isStrong) return Strings.errorPasswordTooWeak;
    return null;
  }

  static String? passwordValidator(String? value) {
    final password = value ?? '';

    if (password.isEmpty) return Strings.validationPasswordEmpty;
    if (password.length < 8) return Strings.errorPasswordTooShort;

    return null;
  }

  static String? nameValidator(String? text) {
    final name = text?.trim() ?? '';
    if (name.isEmpty) return 'O nome é obrigatório';
    if (name.length < 6) return 'O nome precisa ter pelo menos 6 caracteres';
    return null;
  }

  static String? nameuploadFormText(String? text) {
    final name = text?.trim() ?? '';
    if (name.isEmpty) return 'Campo é obrigatório';
    if (name.length < 2) return 'O texto precisa ter pelo menos 2 caracteres';
    return null;
  }
}
