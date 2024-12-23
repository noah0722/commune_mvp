import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/user.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<User?> getUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return User.fromFirestore(doc);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> createUser(User user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(userId).update(data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateLastLogin(String userId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> joinMu(String userId, String muId) async {
    try {
      final batch = _db.batch();

      // Update user's joined Mus
      batch.update(
        _db.collection('users').doc(userId),
        {
          'joinedMus': FieldValue.arrayUnion([muId]),
        },
      );

      // Update Mu's member count
      batch.update(
        _db.collection('mus').doc(muId),
        {
          'memberCount': FieldValue.increment(1),
        },
      );

      await batch.commit();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> leaveMu(String userId, String muId) async {
    try {
      final batch = _db.batch();

      batch.update(
        _db.collection('users').doc(userId),
        {
          'joinedMus': FieldValue.arrayRemove([muId]),
        },
      );

      batch.update(
        _db.collection('mus').doc(muId),
        {
          'memberCount': FieldValue.increment(-1),
        },
      );

      await batch.commit();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateRecentMus(String userId, String muId) async {
    try {
      final user = await getUser(userId);
      if (user == null) return;

      final recentMus = List<String>.from(user.recentMus);
      recentMus.remove(muId);
      recentMus.insert(0, muId);

      if (recentMus.length > 10) {
        recentMus.removeLast();
      }

      await _db.collection('users').doc(userId).update({
        'recentMus': recentMus,
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCommorePoints(String userId, int points) async {
    try {
      await _db.collection('users').doc(userId).update({
        'commorePoints': FieldValue.increment(points),
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> savePost(String userId, String postId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'savedPosts': FieldValue.arrayUnion([postId]),
      });
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> unsavePost(String userId, String postId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'savedPosts': FieldValue.arrayRemove([postId]),
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
          return '사용자를 찾을 수 없어요';
        case 'already-exists':
          return '이미 존재하는 사용자에요';
        default:
          return '오류가 발생했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}

final userServiceProvider = Provider<UserService>((ref) => UserService());
