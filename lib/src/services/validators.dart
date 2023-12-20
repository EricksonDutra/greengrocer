import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) return 'Digite seu email';

  if (!email.isEmail) return 'Digite um email válido';
  return null;
}

String? passwordValidador(String? senha) {
  if (senha == null || senha.isEmpty) return 'Digite seu senha!!';

  if (senha.length < 5) return 'A senha deve conter pelo menos 5 dígitos!!';
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) return 'Digite um nome!';

  if ((name.split(' ').length) < 2) return 'Digite um nome composto';

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) return 'Digite um número de celular!';

  if (!phone.isPhoneNumber || phone.length < 14) return 'Digite um número de celular válido';

  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) return 'Digite um CPF!';

  if (!cpf.isPhoneNumber) return 'Digite um número de CPF válido';

  return null;
}
