class Validators {
  static bool isValidLogin({required String username, required String password}) {
    return username.trim() == 'admin' && password.trim() == 'admin';
  }
}

