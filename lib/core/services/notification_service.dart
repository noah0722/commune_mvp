import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:commune/core/models/notification.dart' as model;

class NotificationService {
  final _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final _db = FirebaseFirestore.instance;

  Future<void> initialize() async {
    // Configure local notifications
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(initSettings);

    // Request notification permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle FCM messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'commune_notification_channel',
      'Commune Notifications',
      channelDescription: 'Commune app notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: message.data['route'],
    );
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    // Handle notification tap
    final route = message.data['route'];
    if (route != null) {
      // Navigate using route
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

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);
