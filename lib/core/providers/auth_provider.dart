import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/user.dart';
import 'package:commune/core/services/auth_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges();
});

final authProvider = Provider<AuthService>((ref) {
  return ref.read(authServiceProvider);
});

final isAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(authStateProvider).value;
  return user?.isAdmin ?? false;
});

final loggedInUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});