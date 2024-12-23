import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/user.dart';
import 'package:commune/core/services/user_service.dart';

class AuthResult {
  final User user;
  final bool isNewUser;

  AuthResult({
    required this.user,
    required this.isNewUser,
  });
}

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final UserService _userService;

  AuthService(this._userService);

  Future<AuthResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google 로그인이 취소되었어요');

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = 
          await _auth.signInWithCredential(credential);
      
      final firebaseUser = userCredential.user!;
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      final user = User(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        username: firebaseUser.displayName ?? '사용자',
        displayName: firebaseUser.displayName,
        profileImage: firebaseUser.photoURL,
        isAdmin: firebaseUser.email == 'youngkwonyu@gmail.com',
        createdAt: DateTime.now(),
      );
      
      if (isNewUser) {
        await _userService.createUser(user);
      } else {
        await _userService.updateLastLogin(user.id);
      }

      return AuthResult(
        user: user,
        isNewUser: isNewUser,
      );
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('로그인이 필요해요');
      
      await _userService.deleteUser(user.uid);
      await user.delete();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return _userService.getUser(firebaseUser.uid);
    });
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return '사용자를 찾을 수 없어요';
        case 'wrong-password':
          return '비밀번호가 올바르지 않아요';
        case 'invalid-email':
          return '올바른 이메일 형식이 아니에요';
        case 'user-disabled':
          return '계정이 비활성화되었어요';
        case 'operation-not-allowed':
          return '해당 로그인 방식이 비활성화되었어요';
        case 'too-many-requests':
          return '잠시 후 다시 시도해주세요';
        default:
          return '로그인에 실패했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
    final userService = ref.read(userServiceProvider);
  return AuthService(userService);
});