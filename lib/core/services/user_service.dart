import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:commune/core/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<User?> getUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return User.fromFirestore(doc);
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }

  Future<void> createUser(User user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      debugPrint('Error creating user: $e');
      rethrow;
    }
  }

  Future<void> updateLastLogin(String userId) async {
    try {
      await _db.collection('users').doc(userId).update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error updating last login: $e');
      // Don't rethrow - this is non-critical
    }
  }

// Add these methods to the UserService class
  Future<void> joinMu(String userId, String muId) async {
    try {
      final batch = _db.batch();

      batch.update(
        _db.collection('users').doc(userId),
        {
          'joinedMus': FieldValue.arrayUnion([muId]),
        },
      );

      batch.update(
        _db.collection('mus').doc(muId),
        {
          'memberCount': FieldValue.increment(1),
        },
      );

      await batch.commit();
    } catch (e) {
      debugPrint('Error joining mu: $e');
      rethrow;
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
      debugPrint('Error leaving mu: $e');
      rethrow;
    }
  }
}

final userServiceProvider = Provider<UserService>((ref) => UserService());
