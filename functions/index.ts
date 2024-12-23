import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

export const awardCommorePoints = functions
  .region('asia-northeast3')
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        '로그인이 필요해요'
      );
    }

    const { userId, type, points } = data;
    const db = admin.firestore();
    
    try {
      await db.runTransaction(async (transaction) => {
        // Create commore transaction
        const commoreRef = db.collection('commore_transactions').doc();
        transaction.set(commoreRef, {
          userId,
          type,
          amount: points,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        
        // Update user's total points
        const userRef = db.collection('users').doc(userId);
        transaction.update(userRef, {
          commorePoints: admin.firestore.FieldValue.increment(points),
        });
        
        // Create notification
        const notificationRef = db.collection('notifications').doc();
        transaction.set(notificationRef, {
          userId,
          type: 'commoreReceived',
          message: '코몰이 지급되었어요',
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      });
      
      return { success: true };
    } catch (error) {
      throw new functions.https.HttpsError('internal', error.message);
    }
});

export const handleNewPost = functions
  .region('asia-northeast3')
  .firestore
  .document('posts/{postId}')
  .onCreate(async (snapshot, context) => {
    const post = snapshot.data();
    const db = admin.firestore();
    
    try {
      // Get all users following this mu
      const users = await db.collection('users')
        .where('joinedMus', 'array-contains', post.muId)
        .get();
        
      const batch = db.batch();
      
      // Create notifications for each follower
      users.docs.forEach((userDoc) => {
        if (userDoc.id !== post.userId) {
          const notificationRef = db.collection('notifications').doc();
          batch.set(notificationRef, {
            userId: userDoc.id,
            type: 'newPost',
            message: '새로운 포스트가 등록되었어요',
            relatedId: context.params.postId,
            isRead: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      });
      
      await batch.commit();
    } catch (error) {
      console.error('Error creating notifications:', error);
    }
});

export const handleNewComment = functions
  .region('asia-northeast3')
  .firestore
  .document('comments/{commentId}')
  .onCreate(async (snapshot, context) => {
    const comment = snapshot.data();
    const db = admin.firestore();
    
    try {
      const batch = db.batch();

      // Update post comment count
      batch.update(
        db.collection('posts').doc(comment.postId),
        {
          'commentCount': admin.firestore.FieldValue.increment(1)
        }
      );

      // Create notifications
      if (comment.parentId) {
        // Notify parent comment author
        const parentComment = await db.collection('comments')
          .doc(comment.parentId)
          .get();
        
        if (parentComment.exists && 
            parentComment.data()?.userId !== comment.userId) {
          const notificationRef = db.collection('notifications').doc();
          batch.set(notificationRef, {
            userId: parentComment.data()?.userId,
            type: 'newReply',
            message: '답글이 달렸어요',
            relatedId: comment.postId,
            isRead: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      } else {
        // Notify post author
        const post = await db.collection('posts')
          .doc(comment.postId)
          .get();
        
        if (post.exists && post.data()?.userId !== comment.userId) {
          const notificationRef = db.collection('notifications').doc();
          batch.set(notificationRef, {
            userId: post.data()?.userId,
            type: 'newComment',
            message: '댓글이 달렸어요',
            relatedId: comment.postId,
            isRead: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        }
      }

      await batch.commit();
    } catch (error) {
      console.error('Error handling new comment:', error);
    }
});

export const cleanupOldNotifications = functions
  .region('asia-northeast3')
  .pubsub
  .schedule('every 24 hours')
  .onRun(async (context) => {
    const db = admin.firestore();
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    
    try {
      const oldNotifications = await db.collection('notifications')
        .where('createdAt', '<', thirtyDaysAgo)
        .where('isRead', '==', true)
        .get();
        
      const batch = db.batch();
      oldNotifications.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });
      
      await batch.commit();
    } catch (error) {
      console.error('Error cleaning up notifications:', error);
    }
});