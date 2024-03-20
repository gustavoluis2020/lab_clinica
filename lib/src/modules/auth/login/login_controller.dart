import 'package:asyncstate/asyncstate.dart';
import 'package:clinic_core/clinic_core.dart';
import 'package:lab_clinicas_self_service/src/services/user_login_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessageStateMixin {
  LoginController({
    required UserLoginService loginService,
  }) : _loginService = loginService;

  final UserLoginService _loginService;

  final _obscurePassword = signal(true);

  bool get obscurePassword => _obscurePassword();

  void passwordTogle() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  void dispose() {
    _obscurePassword.dispose();
  }

  final _logged = signal(false);
  bool get logged => _logged();

  Future<void> login(String email, String password) async {
    final loginResult = await _loginService.execute(email, password).asyncLoader();
    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
