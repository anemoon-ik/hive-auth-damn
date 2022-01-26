import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hive_demo/model/user.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFB(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.email, user.uid);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFB);
  }

  Future<User?>? signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFB(credential.user);
  }

  Future<User?>? createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFB(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
