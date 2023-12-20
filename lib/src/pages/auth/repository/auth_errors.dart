String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha errado.';

    default:
      return 'Um erro não definido ocorreu';
  }
}
