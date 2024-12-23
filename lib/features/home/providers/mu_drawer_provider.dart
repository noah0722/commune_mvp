// #File: lib/features/home/providers/mu_drawer_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commune/core/models/mu.dart';
import 'package:commune/core/providers/auth_provider.dart';

final recentMusProvider = StreamProvider<List<Mu>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null || user.recentMus.isEmpty) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('mus')
      .where(FieldPath.documentId, whereIn: user.recentMus)
      .snapshots()
      .map((snapshot) => 
          snapshot.docs.map((doc) => Mu.fromFirestore(doc)).toList());
});

final myMusProvider = StreamProvider<List<Mu>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null || user.joinedMus.isEmpty) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('mus')
      .where(FieldPath.documentId, whereIn: user.joinedMus)
      .snapshots()
      .map((snapshot) => 
          snapshot.docs.map((doc) => Mu.fromFirestore(doc)).toList());
});

final popularMusProvider = StreamProvider<List<Mu>>((ref) {
  return FirebaseFirestore.instance
      .collection('mus')
      .orderBy('memberCount', descending: true)
      .limit(20)
      .snapshots()
      .map((snapshot) => 
          snapshot.docs.map((doc) => Mu.fromFirestore(doc)).toList());
});

final expandedCategoryProvider = StateProvider<String?>((ref) => null);

final muDrawerSearchQueryProvider = StateProvider<String>((ref) => '');

final muDrawerSearchResultsProvider = StreamProvider<List<Mu>>((ref) {
  final query = ref.watch(muDrawerSearchQueryProvider);
  
  if (query.isEmpty) {
    return Stream.value([]);
  }

  return FirebaseFirestore.instance
      .collection('mus')
      .where('name', isGreaterThanOrEqualTo: query)
      .where('name', isLessThan: query + 'z')
      .limit(5)
      .snapshots()
      .map((snapshot) => 
          snapshot.docs.map((doc) => Mu.fromFirestore(doc)).toList());
});