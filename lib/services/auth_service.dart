import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signUp(
      {required String email, required String password}) async {
        if (email.isEmpty || password.isEmpty) {
      return 'Preencha todos os campos.';
      }
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null; // Retorna null se não houver erro
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e);
    } catch (e) {
      return "Ocorreu um erro inesperado.";
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Preencha todos os campos.';
    }
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e);
    } catch (e) {
      return "Ocorreu um erro inesperado.";
    }
  }

  Future<String?> signOut() async {
    try{
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e);
    }
    return null;
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e);
    } catch (e) {
      return "Ocorreu um erro inesperado.";
    }
    return null;
  }

  // Método privado para tratar os erros de autenticação
  String handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';
      case 'email-already-in-use':
        return 'E-mail já cadastrado.';
      case 'user-not-found':
        return 'Nenhum usuário encontrado para esse e-mail.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'invalid-credential':
        return 'Senha inválida.';
      default:
        return 'Ocorreu um erro. Código: ${e.code}';
    }
  }
}
