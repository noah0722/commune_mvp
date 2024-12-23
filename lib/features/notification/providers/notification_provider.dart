// #File: lib/features/notification/providers/notification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/providers/auth_provider.dart';
import 'package:commune/core/models/notification.dart' as model;

final notificationsProvider = StreamProvider<List<model.Notification>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('notifications')
      .where('userId', isEqualTo: user.id)
      .orderBy('createdAt', descending: true)
      .limit(50)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => model.Notification.fromFirestore(doc))
          .toList());
});

final unreadNotificationCountProvider = StreamProvider<int>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value(0);

  return FirebaseFirestore.instance
      .collection('notifications')
      .where('userId', isEqualTo: user.id)
      .where('isRead', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final _db = FirebaseFirestore.instance;

  Future<void> markAsRead(String notificationId) async {
    try {
      await _db
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> markAllAsRead(String userId) async {
    try {
      final batch = _db.batch();
      final notifications = await _db
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      for (final doc in notifications.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _db.collection('notifications').doc(notificationId).delete();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteAllNotifications(String userId) async {
    try {
      final batch = _db.batch();
      final notifications = await _db
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .get();

      for (final doc in notifications.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> createNotification({
    required String userId,
    required model.NotificationType type,
    required String message,
    String? title,
    String? imageUrl,
    String? actionUrl,
    Map<String, dynamic>? data,
  }) async {
    try {
      final notification = model.Notification(
        id: '',
        userId: userId,
        type: type,
        message: message,
        title: title,
        imageUrl: imageUrl,
        actionUrl: actionUrl,
        data: data,
        createdAt: DateTime.now(),
      );

      await _db.collection('notifications').add(notification.toJson());
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return '알림 권한이 없어요';
        case 'not-found':
          return '알림을 찾을 수 없어요';
        default:
          return '알림 처리에 실패했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}
