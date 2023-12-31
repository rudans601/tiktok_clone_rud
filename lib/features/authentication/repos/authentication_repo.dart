import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth =
      FirebaseAuth.instance; //firebaseAuth instance를 만들면 firebase와 소통
  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  //String get uid => null;

  Stream<User?> authStateChanges() => _firebaseAuth
      .authStateChanges(); //firebaseAuth의 stream을 노출시키기 유저가 인증됐는지(로그인)됐는지 확인하는 함수?

  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        //이메일과 비밀번호를 회원으로 추가
        email: email,
        password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth
        .signInWithProvider(GithubAuthProvider()); //github, apple, 변경 가능
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
final authState = StreamProvider(
  //유저의 인증상태 변화를 감지하는 provider, 10행
  (ref) {
    final repo = ref.read(authRepo);
    return repo.authStateChanges();
  },
);
