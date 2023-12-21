String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha errado.';

    case 'Invalid session token':
      return 'Token invalido ';

    case 'INVALID_FULLNAME':
      return 'Ocorreu um erro a o cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreu um erro a o cadastrar usuário: Celular inválido';

    case 'INVALID_cpf':
      return 'Ocorreu um erro a o cadastrar usuário: CPF inválido';

    default:
      return 'Um erro não definido ocorreu';
  }
}
