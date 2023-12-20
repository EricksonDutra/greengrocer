String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha errado.';

    case 'Invalid session token':
      return 'Token invalido ';

    default:
      return 'Um erro não definido ocorreu';
  }
}
