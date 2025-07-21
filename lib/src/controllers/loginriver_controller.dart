import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utilidades/src/models/LoginState.dart';

class LoginRiverController extends StateNotifier<LoginState> {
  LoginRiverController() : super(LoginState());

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<void> submitLogin() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(seconds: 2));
    state = state.copyWith(isLoading: false);

    if (state.email == "alani@gmail.com" && state.password == '1234') {
      print("login ok");
    } else {
      print("Login errado");
    }
  }
}
