// lib/core/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:commune/core/models/user.dart' as model;
import 'package:commune/core/services/user_service.dart';

class AuthResult {
  AuthResult({
    required this.user,
    required this.isNewUser,
  });
  final model.User user;
  final bool isNewUser;
}

class AuthService {
  AuthService(this._userService);
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '754049704230-ludrtr61om8me27ct1d5t5pc9hm9as5b.apps.googleusercontent.com'
        : null,
    scopes: [
      'email',
      'profile',
    ],
  );
  final UserService _userService;

  Future<model.User?> _handleAuthResult(UserCredential userCredential) async {
    final firebaseUser = userCredential.user;
    if (firebaseUser == null) return null;

    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

    try {
      if (isNewUser) {
        final user = model.User(
          id: firebaseUser.uid,
          email: firebaseUser.email!,
          username: firebaseUser.displayName ?? '사용자',
          displayName: firebaseUser.displayName,
          profileImage: firebaseUser.photoURL,
          isAdmin: firebaseUser.email == 'youngkwonyu@gmail.com',
          createdAt: DateTime.now(),
        );

        await _userService.createUser(user);
        return user;
      } else {
        await _userService.updateLastLogin(firebaseUser.uid);
        return await _userService.getUser(firebaseUser.uid);
      }
    } catch (e) {
      debugPrint('Error handling auth result: $e');
      return null;
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    try {
      UserCredential? userCredential;

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final googleUser = await _googleSignIn.signInSilently() ??
            await _googleSignIn.signIn();
        if (googleUser == null) throw Exception('Google 로그인이 취소되었어요');

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      final firebaseUser = userCredential.user!;
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      final user = model.User(
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
      debugPrint('Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      debugPrint('Sign out error: $e');
      rethrow;
    }
  }

  Stream<model.User?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;
      return _userService.getUser(firebaseUser.uid);
    });
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final userService = ref.read(userServiceProvider);
  return AuthService(userService);
});
