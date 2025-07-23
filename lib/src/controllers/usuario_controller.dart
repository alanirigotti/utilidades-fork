import 'package:utilidades/src/models/usuario_model.dart';
import 'package:utilidades/src/services/auth_firebase_service.dart';

class UsuarioController {
  final AuthFirebaseService _authService = AuthFirebaseService();

  Future<UsuarioModel?> cadastrar(String nome, String email, String senha) {
    return _authService.registrarUsuario(nome, email, senha);
  }

  Future<UsuarioModel?> autenticar(String email, String senha) {
    return _authService.login(email, senha);
  }
}
