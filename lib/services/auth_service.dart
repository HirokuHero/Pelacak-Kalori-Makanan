import '../core/utils/validators.dart';

class AuthService {
  bool login({required String username, required String password}) {
    return Validators.isValidLogin(username: username, password: password);
  }
}

