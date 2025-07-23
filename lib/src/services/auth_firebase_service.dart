import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utilidades/src/models/usuario_model.dart';

class AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UsuarioModel?> registrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      UsuarioModel usuario = UsuarioModel(
        uid: cred.user!.uid,
        nome: nome,
        email: email,
      );
      await _firestore
          .collection('usuarios')
          .doc(usuario.uid)
          .set(usuario.toMap());
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      return null;
    }
  }

  Future<UsuarioModel?> login(String email, String senha) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      DocumentSnapshot snapshot =
          await _firestore.collection('usuarios').doc(cred.user!.uid).get();
      return UsuarioModel.fromMap(snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Erro ao efetuar login: $e");
      return null;
    }
  }
}
