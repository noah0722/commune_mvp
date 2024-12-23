import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/commore_transaction.dart';
import 'package:commune/core/services/user_service.dart';
import 'package:commune/core/services/notification_service.dart';
import 'package:commune/core/models/notification.dart';

class CommoreService {
  CommoreService(this._userService, this._notificationService);
  final _db = FirebaseFirestore.instance;
  final UserService _userService;
  final NotificationService _notificationService;

  Future<void> awardPoints({
    required String userId,
    required CommoreActionType type,
    required int amount,
    String? relatedId,
    String? description,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final batch = _db.batch();

      // Create commore transaction
      final transactionRef = _db.collection('commore_transactions').doc();
      final transaction = CommoreTransaction(
        id: transactionRef.id,
        userId: userId,
        type: type,
        amount: amount,
        relatedId: relatedId,
        description: description,
        metadata: metadata,
        createdAt: DateTime.now(),
      );

      batch.set(transactionRef, transaction.toJson());

      // Update user's total points
      batch.update(
        _db.collection('users').doc(userId),
        {
          'commorePoints': FieldValue.increment(amount),
        },
      );

      await batch.commit();

      // Send notification
      await _notificationService.createNotification(
        userId: userId,
        type: NotificationType.commoreReceived,
        message: '$amount코몰이 지급되었어요',
        data: {
          'amount': amount,
          'type': type.toString(),
        },
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<CommoreTransaction>> getUserTransactions(
    String userId, {
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      var query = _db
          .collection('commore_transactions')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final snapshot = await query.get();
      return snapshot.docs.map(CommoreTransaction.fromFirestore).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(dynamic error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return '코몰 지급 권한이 없어요';
        case 'not-found':
          return '사용자를 찾을 수 없어요';
        default:
          return '코몰 지급에 실패했어요';
      }
    }
    return error?.toString() ?? '알 수 없는 오류가 발생했어요';
  }
}

final commoreServiceProvider = Provider<CommoreService>((ref) {
  final userService = ref.read(userServiceProvider);
  final notificationService = ref.read(notificationServiceProvider);
  return CommoreService(userService, notificationService);
});
