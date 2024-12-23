// #File: lib/features/mu/providers/mu_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/core/services/user_service.dart';

final muProvider = StreamProvider.family<Mu?, String>((ref, muId) {
  final db = FirebaseFirestore.instance;
  
  return db.collection('mus')
      .doc(muId)
      .snapshots()
      .map((doc) => doc.exists ? Mu.fromFirestore(doc) : null);
});

final muServiceProvider = Provider<MuService>((ref) {
  final userService = ref.read(userServiceProvider);
  return MuService(userService);
});

class MuService {
  final _db = FirebaseFirestore.instance;
  final UserService _userService;

  MuService(this._userService);

  Future<void> joinMu(String userId, String muId) async {
    try {
      await _userService.joinMu(userId, muId);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> leaveMu(String userId, String muId) async {
    try {
      await _userService.leaveMu(userId, muId);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateLastActivity(String muId) async {
    try {
      await _db.collection('mus').doc(muId).update({
        'lastActivityAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> incrementPostCount(String muId) async {
    try {
      await _db.collection('mus').doc(muId).update({
        'postCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return '권한이 없어요';
        case 'not-found':
          return '뮤를 찾을 수 없어요';
        default:
          return '뮤 작업 중 오류가 발생했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}